#-------------------------------------------------
#
# Project created by QtCreator 2013-03-29T19:05:35
#
#-------------------------------------------------

QT       += core dbus
QT       -= gui

TARGET = bachaod

CONFIG   -= app_bundle
CONFIG   += console mobility

MOBILITY += multimedia location messaging

TEMPLATE = app

daemonconf.path = /etc/init/apps
daemonconf.files = bachaod.conf

servicexml.path = /etc/init/apps
servicexml.files = bachaoservice.xml

target.path = /opt/bachao/bin

INSTALLS += target servicexml daemonconf

HEADERS += \
    bachao-daemon.h \
    abstractinputsource.h \
    gpsdatasource.h \
    bachaodaemonserviceinterface.h \
    gpsretryproxy.h

SOURCES += main.cpp \
    bachao-daemon.cpp \
    abstractinputsource.cpp \
    gpsdatasource.cpp \
    bachaodaemonserviceinterface.cpp \
    gpsretryproxy.cpp

DEFINES += WRITE_LOG_TO_FILE
