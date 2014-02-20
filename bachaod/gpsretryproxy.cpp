#include "gpsretryproxy.h"

#include <QtCore/QTimer>
#include <QDebug>

GpsRetryProxy::GpsRetryProxy(QGeoPositionInfoSource *gpsSource, int timeout, QObject *parent) :
    QObject(parent),
    m_gpsSource(gpsSource),
    m_timeout(timeout)
{
    QTimer::singleShot(2000, this, SLOT(retry()));
}

void GpsRetryProxy::retry()
{
    qDebug() << "Retrying now...";
    m_gpsSource->requestUpdate(m_timeout);
    deleteLater();
}
