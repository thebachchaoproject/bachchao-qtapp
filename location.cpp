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
