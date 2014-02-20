#ifndef GPSDATASOURCE_H
#define GPSDATASOURCE_H

#include "abstractinputsource.h"

#include <QtCore/QPointer>
#include <QtCore/QTimer>
#include <QtLocation/QGeoPositionInfoSource>

// QtMobility namespace
QTM_USE_NAMESPACE

class GpsDataSource : public AbstractInputSource
{
    Q_OBJECT
public:
    explicit GpsDataSource(QObject *parent = 0);
    QString sourceName();

public slots:
    void start();
    void stop();
    void reloadConfig();

    void updateLocation();
    void sendUpdate();
    void sendEmergency();

private slots:
    void updateTimeout();
    void processPositionUpdate(const QGeoPositionInfo &update);
    void processPositionUpdateAndSendUpdateSms(const QGeoPositionInfo &update);
    void processPositionUpdateAndSendEmergencySms(const QGeoPositionInfo &update);

private:
    class Private;
    Private * const d;

    QGeoPositionInfoSource* getGeoPositionInfoSource();
    void deleteGPS();
    int getUpdateInterval() const;
    void sendSms(const QString &messageToPrepend);
};

#endif // GPSDATASOURCE_H
