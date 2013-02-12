#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "location.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/bachao/main.qml"));
    viewer.showExpanded();

    Location locationObj;
    QObject::connect(app, SIGNAL(aboutToQuit()),
                     &locationObj, SLOT(stopUpdate()));

    return app->exec();
}
