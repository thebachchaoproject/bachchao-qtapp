#include <QtCore/QCoreApplication>

//#include "bachaodaemon.h"
//#include "location.h"
//#include "stdio.h"
#include "bachao-daemon.h"

#include <QRemoteServiceRegister>
#include <QServiceManager>

int main(int argc, char *argv[])
{
//    BachaoDaemon::init_daemon();
    QCoreApplication a(argc, argv);

    // Create daemon
    BachaoDaemon daemon;

    // Create service
    // Create, register and publish IPC based service object
    const QString serviceName("BachaoService");
    const QString interfaceName("com.nokia.qt.examples.bachaodaemon");
    const QString serviceVersion("1.0");

    QtMobility::QServiceManager manager;

    // Remove old service
    manager.removeService(serviceName);

    // Add service
    bool addServiceOk = manager.addService("bachaoservice.xml");
    Q_ASSERT(addServiceOk);

    // Entry
    QtMobility::QRemoteServiceRegister serviceRegister;
    QtMobility::QRemoteServiceRegister::Entry entry =
            serviceRegister.createEntry<BachaoDaemon>(serviceName, interfaceName, serviceVersion);

    // Publish
    serviceRegister.publishEntries("bachaodaemon");

    // Keep service running
    serviceRegister.setQuitOnLastInstanceClosed(false);

    return a.exec();
}
