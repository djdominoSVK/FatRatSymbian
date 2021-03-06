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
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

In addition, as a special exemption, Luboš Doležel gives permission
to link the code of FatRat with the OpenSSL project's
"OpenSSL" library (or with modified versions of it that use the; same
license as the "OpenSSL" library), and distribute the linked
executables. You must obey the GNU General Public License in all
respects for all of the code used other than "OpenSSL".
*/

#ifndef PROXY_H
#define PROXY_H
#include <QString>
#include <QUuid>
#include <QtNetwork/QNetworkProxy>
#include <QtNetwork/QHttp>

struct Proxy
{
	Proxy() : nType(ProxyNone) {}
	
	QString strName, strIP, strUser, strPassword;
	quint16 nPort;
	enum ProxyType { ProxyNone=-1, ProxyHttp, ProxySocks5 } nType;
	QUuid uuid;
    bool enabled;
	
	QString toString() const
	{
		return QString("%1 (%2)").arg(strName).arg( (nType==0) ? "HTTP" : "SOCKS 5");
	}
    static void saveProxy(int index, QString name,QString ip,QString port, QString user, QString pass, bool enabled) ;
    static bool isProxyEnabled();
	operator QNetworkProxy() const;
    static QString getName();
    static Proxy loadProxy();
	static Proxy getProxy(QUuid uuid);
};

#endif
