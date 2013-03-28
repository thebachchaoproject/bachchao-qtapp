#include "location.h"

#include <QDebug>

Location::Location(QObject *parent)
    : QObject(parent)
{
    source = QGeoPositionInfoSource::createDefaultSource(this);
    if (source) {
        connect(source, SIGNAL(positionUpdated(QGeoPositionInfo)),
                this, SLOT(positionUpdated(QGeoPositionInfo)));
        source->startUpdates();
    }
}

void Location::positionUpdated(const QGeoPositionInfo &info)
{
    qDebug() << "Position updated:" << info;
}

void Location::stopUpdate()
{
    disconnect(source, SIGNAL(positionUpdated(QGeoPositionInfo)),
                       this, SLOT(positionUpdated(QGeoPositionInfo)));
    source->stopUpdates();
}

void Location::setLocationUpdateInterval(int interval)
{
    switch(interval) {
        case OneHour:
                source->setUpdateInterval(3600000);
                break;
        case SixHour:
                source->setUpdateInterval(3600000);
                break;
        case OneDay:
                source->setUpdateInterval(3600000);
                break;
        case OnlyWhenPressedBachao:
                source->setUpdateInterval(3600000);
                break;
    }
}
