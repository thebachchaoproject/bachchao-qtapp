TEMPLATE = subdirs
CONFIG += ordered
SUBDIRS += src \
        bachaod

desktop.files = bachao_harmattan.desktop
desktop.path = /usr/share/applications/
icon.files = bachao80.png
icon.path = /usr/share/icons/hicolor/80x80/apps/

INSTALLS += desktop mydaemon icon

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

