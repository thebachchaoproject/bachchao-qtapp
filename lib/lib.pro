TEMPLATE = lib
TARGET = bachao-client
DEPENDPATH += . 
INCLUDEPATH += .  \
                 /usr/include/libsynccommon \
                 /usr/include/libsyncprofile 

LIBS += -lsyncpluginmgr -lsyncprofile

CONFIG += debug plugin mobility meegotouchevents
MOBILITY += location

QT += dbus network
QT -= gui

#install
target.path = /usr/lib/sync/ 

client.path = /etc/sync/profiles/client 
client.files = xml/bachao.xml

sync.path = /etc/sync/profiles/sync
sync.files = xml/sync/*

service.path = /etc/sync/profiles/service
service.files = xml/service/*

HEADERS += \
    bachao-service.h \
    location.h

SOURCES += \
    bachao-service.cpp \
    location.cpp

header.path = /usr/include/bachao/
header.files = location.h

INSTALLS += target client sync service header
