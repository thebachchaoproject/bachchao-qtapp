#-------------------------------------------------
#
# Project created by QtCreator 2013-03-29T19:05:35
#
#-------------------------------------------------

QT       += core

#QT       -= gui

TARGET = bachaod
CONFIG   += console mobility
MOBILITY += multimedia \
        location \
        serviceframework
CONFIG   -= app_bundle

TEMPLATE = app

#mydaemon.path = /etc/init/apps
#mydaemon.files = bachaod.conf

#SOURCES += main.cpp \
#    location.cpp

target.path = /opt/bachao/bin
servicexml.path = /etc/init/apps
servicexml.files = bachaoservice.xml

INSTALLS += target servicexml
OTHER_FILES += bachaoservice.xml

#HEADERS += \
#    location.h \
#    bachaodaemon.h

HEADERS += \
    bachao-daemon.h

SOURCES += main.cpp \
    bachao-daemon.cpp

DEFINES += WRITE_LOG_TO_FILE
