#ifndef BACHAODAEMON_H
#define BACHAODAEMON_H

#include <QObject>
#include <QPointer>
#include <QFile>
#include <QTextStream>
#include <QVariant>
#include <QSettings>

// QtMobility API headers
#include <QGeoPositionInfoSource>
#include <QGeoPositionInfo>

// QtMobility namespace
QTM_USE_NAMESPACE

class Message;
class BachaoDaemon: public QObject
{
Q_OBJECT

public:
    BachaoDaemon(QObject *parent = 0);
    ~BachaoDaemon();

signals:
    // GPS started
    void gpsInitialized();
    // GPS closed
    void gpsClosed();

private:
    void createGPS();
    void deleteGPS();
    int updateTime();

private slots:

    void updateTimeout();
    void positionUpdated(QGeoPositionInfo);

    // Log messages into text file
    void log(QString str);

    void startGps();

private:
    QPointer<QGeoPositionInfoSource> m_location;
    QFile* m_file;
    QTextStream m_outStream;
    QSettings* m_settings;

};


#endif // BACHAODAEMON_H
