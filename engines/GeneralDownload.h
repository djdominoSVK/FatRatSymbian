/*
FatRat download manager
http://fatrat.dolezel.info

Copyright (C) 2006-2008 Lubos Dolezel <lubos a dolezel.info>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
version 2 as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.
*/

#ifndef _GENERALDOWNLOAD_H
#define _GENERALDOWNLOAD_H

#ifdef WITH_SFTP
#	define GENERALDOWNLOAD_DESCR "HTTP(S)/FTP/SFTP download"
#else
#	define GENERALDOWNLOAD_DESCR "HTTP(S)/FTP download"
#endif

#include "Transfer.h"
#include <QUrl>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QtNetwork/QHttp>
#include <QPair>
#include <QTime>
#include <QReadWriteLock>
#include <QDialog>
#include "LimitedSocket.h"

class GeneralDownload : public Transfer
{
Q_OBJECT
public:
	GeneralDownload(bool local = false);
	virtual ~GeneralDownload();
	
	virtual void changeActive(bool);
	virtual void speeds(int& down, int& up) const;
	virtual qulonglong total() const { return m_nTotal; }
	virtual qulonglong done() const;
	virtual QString name() const;
	virtual QString myClass() const { return "GeneralDownload"; }
	virtual QString message() const { return m_strMessage; }
	
	virtual void init(QString uri,QString dest);
	virtual void setObject(QString target);
	void init2(QString uri,QString dest);
	virtual void load(const QDomNode& map);
	virtual void save(QDomDocument& doc, QDomNode& map) const;
	virtual QString object() const { return m_dir.path(); }
	
	virtual void setSpeedLimits(int down,int up);	
	static int acceptable(QString uri, bool);
	static Transfer* createInstance() { return new GeneralDownload; }
	
	QString filePath() const { return m_dir.filePath(name()); }
	void setTargetName(QString strName);


	
private slots:
	void requestFinished(bool error);
	void responseSizeReceived(qint64 totalsize);
	void redirected(QString newurl);
	void changeMessage(QString msg) { m_strMessage = msg; }
	void renamed(QString dispName);	
	void switchMirror();
	void connectSignals();
private:
    void startHttp(QUrl url, QUrl referrer = QUrl(),bool redirected = false);
	void startFtp(QUrl url);
	void generateName();
protected:
	QUrl m_urlLast;
	QDir m_dir;
	qulonglong m_nTotal,m_nStart;
	
	QString m_strMessage, m_strFile;
	bool m_bAutoName;
	
	LimitedSocket* m_engine;
	
	struct UrlObject
	{
		QUrl url;
		QString strReferrer, strBindAddress;
		FtpMode ftpMode;
		QUuid proxy;
	};
	QList<UrlObject> m_urls;
	int m_nUrl;

};

#endif

