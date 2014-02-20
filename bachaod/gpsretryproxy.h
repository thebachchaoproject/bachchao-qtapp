#ifndef GPSRETRYPROXY_H
#define GPSRETRYPROXY_H

#include <QObject>
#include <QtLocation/QGeoPositionInfoSource>

QTM_USE_NAMESPACE

class GpsRetryProxy : public QObject
{
    Q_OBJECT
public:
    explicit GpsRetryProxy(QGeoPositionInfoSource *gpsSource, int timeout, QObject *parent = 0);
public slots:
    void retry();
private:
    QGeoPositionInfoSource *m_gpsSource;
    int m_timeout;
};

#endif // GPSRETRYPROXY_H
