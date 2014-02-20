#include <QtGui/QApplication>
#include <QtOpenGL/QGLWidget>

#include <QDeclarativeContext>
#include <qdeclarative.h>

#include "qmlapplicationviewer.h"
#include "location.h"
#include "settings.h"
#include "bachaodaemonconnection.h"
#include "videorecorder.h"
#include "settings.h"
#include "imagetobase64adapter.h"

#include "../bachaod/gpsdatasource.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication *app(createApplication(argc, argv));

    qmlRegisterInterface<GpsDataSource>("GpsDataSource");

    qmlRegisterType<BachaoDaemonConnection>("com.example.bachaocomponents", 1, 0, "BachaoDaemonConnection");
    qmlRegisterType<VideoRecorder>("com.example.bachaocomponents", 1, 0, "VideoRecorder");
    qmlRegisterType<Settings>("com.example.bachaocomponents", 1, 0, "Settings");
    qmlRegisterType<ImageToBase64Adapter>("com.example.bachaocomponents", 1, 0, "ImageToBase64Adapter");

    QmlApplicationViewer *viewer = new QmlApplicationViewer();
    //viewer->setViewport(new QGLWidget());

    QCoreApplication::setOrganizationName("Bachchao");
    QCoreApplication::setApplicationName("BachchaoMobile");

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer->setMainQmlFile(QLatin1String("qml/bachao/main.qml"));
    viewer->showExpanded();

    return app->exec();
}
