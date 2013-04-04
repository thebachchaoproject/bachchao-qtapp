TEMPLATE = subdirs
CONFIG += ordered
SUBDIRS += src \
        bachaod

desktop.files = bachao_harmattan.desktop
desktop.path = /usr/share/applications/

INSTALLS += desktop mydaemon 
