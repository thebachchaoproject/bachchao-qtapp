#include "gpsdatasource.h"

#include "gpsretryproxy.h"

#include <QtLocation/QGeoPositionInfo>
#include <QtCore/QSettings>
#include <QtMessaging/QMessage>
#include <QtMessaging/QMessageService>

#include <QDebug>

static const int UPDATE_TIMEOUT = 20000;

class GpsDataSource::Private
{
public:
    QTimer updateTimer;
    QMessageService messageService;
};

GpsDataSource::GpsDataSource(QObject *parent) :
    AbstractInputSource(parent),
    d(new Private())
{
    connect(&d->updateTimer, SIGNAL(timeout()), SLOT(sendUpdate()));
}

QString GpsDataSource::sourceName()
{
    return "gps";
}

void GpsDataSource::start()
{
    reloadConfig();
    updateLocation();
    emit dataUpdated("Waiting for update");
}

void GpsDataSource::updateLocation()
{
    QGeoPositionInfoSource *geoPositionInfoSource = getGeoPositionInfoSource();
    connect(geoPositionInfoSource, SIGNAL(positionUpdated(QGeoPositionInfo)), SLOT(processPositionUpdate(QGeoPositionInfo)));
    geoPositionInfoSource->requestUpdate(UPDATE_TIMEOUT);
}

void GpsDataSource::sendUpdate()
{
    QGeoPositionInfoSource *geoPositionInfoSource = getGeoPositionInfoSource();
    connect(geoPositionInfoSource, SIGNAL(positionUpdated(QGeoPositionInfo)), SLOT(processPositionUpdateAndSendUpdateSms(QGeoPositionInfo)));
    geoPositionInfoSource->requestUpdate(UPDATE_TIMEOUT);
}

void GpsDataSource::sendEmergency()
{
    QGeoPositionInfoSource *geoPositionInfoSource = getGeoPositionInfoSource();
    connect(geoPositionInfoSource, SIGNAL(positionUpdated(QGeoPositionInfo)), SLOT(processPositionUpdateAndSendEmergencySms(QGeoPositionInfo)));
    geoPositionInfoSource->requestUpdate(UPDATE_TIMEOUT);
}

QGeoPositionInfoSource* GpsDataSource::getGeoPositionInfoSource()
{
    qDebug() << "Creating GPS Position Source...";
    QGeoPositionInfoSource *geoPositionInfoSource = QGeoPositionInfoSource::createDefaultSource(this);
    geoPositionInfoSource->setPreferredPositioningMethods(QGeoPositionInfoSource::AllPositioningMethods);
    QObject::connect(geoPositionInfoSource, SIGNAL(updateTimeout()), this, SLOT(updateTimeout()));

    return geoPositionInfoSource;
}

void GpsDataSource::stop()
{
    d->updateTimer.stop();
    emit dataUpdated("GPS Stopped");
}

void GpsDataSource::updateTimeout()
{
    qDebug() << "Failed to get GPS fix, wait for retry...";
    QGeoPositionInfoSource *geoPositionInfoSource = qobject_cast<QGeoPositionInfoSource*>(sender());
    new GpsRetryProxy(geoPositionInfoSource, UPDATE_TIMEOUT, this);
}

void GpsDataSource::processPositionUpdateAndSendUpdateSms(const QGeoPositionInfo &update)
{
    processPositionUpdate(update);
    sendSms(QSettings().value("messaging/location_update_message").toString());
    sender()->deleteLater();
}

void GpsDataSource::processPositionUpdateAndSendEmergencySms(const QGeoPositionInfo &update)
{
    processPositionUpdate(update);
    sendSms(QSettings().value("messaging/custom_message").toString());
    sender()->deleteLater();
}

void GpsDataSource::processPositionUpdate(const QGeoPositionInfo &update)
{
    qDebug() << "Update from GPS " << update;

    if (!update.isValid()) {
        qWarning() << "Data from GPS is INVALID!";
        return;
    }

    QString data = update.coordinate().toString() + " " + update.timestamp().toString();
    emit dataUpdated(data);

    if (sender()) sender()->deleteLater();
}

void GpsDataSource::reloadConfig()
{
    const int interval = getUpdateInterval();
    if (interval == 0) {  //Never
        d->updateTimer.stop();
    } else if (interval != d->updateTimer.interval()) {
        qDebug() << "SET INTERVAL to " << interval;
        d->updateTimer.setInterval(interval);
        d->updateTimer.start();
    }
}

int GpsDataSource::getUpdateInterval() const
{
    return QSettings().value("location/interval", 0).toInt() * 60 * 60 * 1000;  //hours -> milliseconds
}

void GpsDataSource::sendSms(const QString &messageToPrepend)
{
    qDebug() << "Sending SMS";


    QMessageAddressList phoneNumbers;
    for (int i=0; i<3; i++) {
        const QString phoneNumber = QSettings().value(QString("messaging/location_update_number%1").arg(i)).toString();
        if (!phoneNumber.isEmpty()) phoneNumbers.append(QMessageAddress(QMessageAddress::Phone, phoneNumber));
    }

    if (phoneNumbers.isEmpty()) {
        qDebug() << "No contacts configured for sending SMS";
        return;
    }

    QMessage message;
    message.setType(QMessage::Sms);
    message.setTo(phoneNumbers);
    message.setBody(lastUpdatedData().prepend(" ").prepend(messageToPrepend));
    d->messageService.send(message);
}
