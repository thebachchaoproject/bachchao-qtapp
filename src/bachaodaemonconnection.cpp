#include "bachaodaemonconnection.h"

#include <QtDBus/QDBusInterface>
#include <QtDBus/QDBusReply>

#include <QDebug>

BachaoDaemonConnection::BachaoDaemonConnection(QObject *parent) :
    QObject(parent)
{
}

QString BachaoDaemonConnection::sourceName() const
{
    return m_sourceName;
}

void BachaoDaemonConnection::setSourceName(const QString &name)
{
    m_sourceName = name;
    if (createInterface()) {
        connect(m_interface, SIGNAL(dataUpdated(QString)), SIGNAL(dataUpdated(QString)));
    } else {
        qWarning() << "Failed to connect to source " << name;
    }

    emit sourceNameChanged();
}

bool BachaoDaemonConnection::createInterface()
{
    qDebug() << "Connecting to source " << m_sourceName;
    const QString dbusPath = m_sourceName.prepend("/");
    m_interface = new QDBusInterface("org.example.bachao", dbusPath);
    return m_interface->isValid();
}

QObject *BachaoDaemonConnection::interface()
{
    return m_interface;
}

void BachaoDaemonConnection::call(const QString &methodName)
{
    if (m_interface && m_interface->isValid()) {
        m_interface->call(methodName);
    } else {
        qWarning() << "Interface is invalid, not calling " << methodName;
    }
}
