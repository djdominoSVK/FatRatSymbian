# Add more folders to ship with the application, here
folder_01.source = qml/FatRatSymbian
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE054DC40

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable
QT += xml \
      network \

# Add dependency to Symbian components
CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    TransfersMethods.cpp \
    TransfersModel.cpp \
    RowData.cpp \
    Settings.cpp \
    SettingsMethods.cpp \
    Transfer.cpp \
    TransferFactory.cpp \
    QueueMgr.cpp \
    Queue.cpp \
    Proxy.cpp \
    Logger.cpp \
    LimitedSocket.cpp \
    Auth.cpp \
    engines/HttpClient.cpp \
    engines/GeneralDownload.cpp \
    engines/FtpUpload.cpp \
    engines/FtpClient.cpp \
    plugins/Plugins.cpp \
    filemodel.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    TransfersMethods.h \
    TransfersModel.h \
    RowData.h \
    RuntimeException.h \
    Settings.h \
    SettingsMethods.h \
    Transfer.h \
    TransferFactory.h \
    QueueMgr.h \
    Queue.h \
    Proxy.h \
    Logger.h \
    LimitedSocket.h \
    Auth.h \
    engines/HttpClient.h \
    engines/GeneralDownload.h \
    engines/FtpUpload.h \
    engines/FtpClient.h \
    plugins/Plugins.h \
    filemodel.h
