#ifndef LOCATION_H
#define LOCATION_H

#include <QObject>
#include <QtLocation/QGeoPositionInfoSource>
#include <QtLocation/QGeoPositionInfo>

using namespace QtMobility;

class Location : public QObject
 {
     Q_OBJECT

 public:

    enum Interval {
        OneHour = 0,
        SixHour,
        OneDay,
        OnlyWhenPressedBachao
    };

    Location(QObject *parent = 0);

 private slots:
     void positionUpdated(const QGeoPositionInfo &info);
     void stopUpdate();
     void setLocationUpdateInterval(int interval);
};

#endif // LOCATION_H
