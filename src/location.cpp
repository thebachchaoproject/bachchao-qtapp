#include "location.h"

#include <QDebug>

Location::Location(QObject *parent)
    : QObject(parent)
{

}

void Location::positionUpdated(const QGeoPositionInfo &info)
{
}

void Location::stopUpdate()
{

}

void Location::setLocationUpdateInterval(int interval)
{

}
