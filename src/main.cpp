#include <QtGui/QApplication>
#include <QtOpenGL/QGLWidget>
#include <QDeclarativeContext>

#include "qmlapplicationviewer.h"
#include "location.h"
#include "settings.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QApplication *app(createApplication(argc, argv));

    QmlApplicationViewer *viewer = new QmlApplicationViewer();
    viewer->setViewport(new QGLWidget());

    QCoreApplication::setOrganizationName("Bachchao");
    QCoreApplication::setApplicationName("Bachchao-qt");

    QDeclarativeContext *context = viewer->rootContext();
    Settings *settings = new Settings(viewer->viewport());
    context->setContextProperty("Settings", settings);

    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/bachao/main.qml"));
    viewer->showExpanded();

    Location locationObj;
    QObject::connect(app, SIGNAL(aboutToQuit()),
                     &locationObj, SLOT(stopUpdate()));

    return app->exec();
}
