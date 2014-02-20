#include "bachaodaemonserviceinterface.h"
#include "bachao-daemon.h"
#include "abstractinputsource.h"

#include <QtDBus/QDBusConnection>

#include <QDebug>

BachaoDaemonServiceInterface::BachaoDaemonServiceInterface(QObject *parent) :
    QObject(parent)
{
    qDebug() << "Attempting to register D-Bus service and interfaces";
    bool success = QDBusConnection::sessionBus().registerService("org.example.bachao");
    if (!success) {
        qWarning("Unable to register D-Bus service");
    } else {
        foreach (AbstractInputSource *source, BachaoDaemon::instance()->sources()) {
            if (source->sourceName().isEmpty()) {
                qWarning() << "Source name is empty, this is not good";
            } else {
                const QString dbusPath = source->sourceName().prepend("/");
                qDebug() << "Exporting source " << dbusPath << " to D-Bus";
                qDebug() << "Success? "
                         << QDBusConnection::sessionBus().registerObject(dbusPath,source, QDBusConnection::ExportAllContents);
            }
        }
    }
}
