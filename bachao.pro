TEMPLATE = subdirs
CONFIG += ordered
SUBDIRS += src \
	lib

desktop.files = bachao_harmattan.desktop
desktop.path = /usr/share/applications/

INSTALLS += desktop 
