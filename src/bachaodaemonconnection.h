#ifndef BACHAODAEMONCONNECTION_H
#define BACHAODAEMONCONNECTION_H

#include <QtCore/QObject>
#include <QtDBus/QDBusInterface>

class BachaoDaemonConnection : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString sourceName READ sourceName WRITE setSourceName NOTIFY sourceNameChanged)
public:
    explicit BachaoDaemonConnection(QObject *parent = 0);

    QString sourceName() const;
    void setSourceName(const QString &name);

    Q_INVOKABLE void call(const QString &methodName);
    Q_INVOKABLE QObject *interface();

signals:
    void sourceNameChanged();
    void dataUpdated(const QString data);

protected:
    bool createInterface();

private:
    QString m_sourceName;
    QDBusInterface *m_interface;
};

#endif // BACHAODAEMONCONNECTION_H
