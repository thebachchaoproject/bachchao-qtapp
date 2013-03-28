# Add more folders to ship with the application, here
folder_01.source = qml/bachao
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
TARGET = bachao

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT += opengl

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += multimedia \
        location \
        contacts
# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    location.cpp \
    settings.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    location.h \
    settings.h
