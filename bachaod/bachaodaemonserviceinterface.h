#ifndef BACHAODAEMONSERVICEINTERFACE_H
#define BACHAODAEMONSERVICEINTERFACE_H

#include <QtDBus/QDBusAbstractAdaptor>

class BachaoDaemonServiceInterface : public QObject
{
    Q_OBJECT
public:
    explicit BachaoDaemonServiceInterface(QObject *parent = 0);
};

#endif // BACHAODAEMONSERVICEINTERFACE_H
