#include "bachao-daemon.h"
#include <QCoreApplication>
#include <QDir>
#include <QDebug>
#include <QTimer>
#include <QDesktopServices>

#include <QRemoteServiceRegister>
#include <QServiceManager>

BachaoDaemon::BachaoDaemon(QObject *parent) :
    QObject(parent)
{
    // For logging messages into text
#ifdef WRITE_LOG_TO_FILE
    QString path("/tmp/bachao.log");
    m_file = new QFile(path);
    // Delete old log file
    if (QFile::exists(path)) {
        QFile::remove(path);
    }
    // Open new log
    m_file->open(QIODevice::WriteOnly | QIODevice::Text  | QIODevice::Append);
    m_outStream.setDevice(m_file);
#endif

    // Create GPS
    log("before create gps");
    createGPS();

    int updateTimeInterval = updateTime();
    //in msec
    updateTimeInterval = updateTimeInterval*60*60*1000;
//     Start GPS
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(startGps()));
    if (updateTimeInterval)
        timer->start(updateTimeInterval);
    log("bachao daemon Started");
}

BachaoDaemon::~BachaoDaemon()
{
    // Stop GPS
    if (m_location) {
        m_location->stopUpdates();
        delete m_location;
    }

#ifdef WRITE_LOG_TO_FILE
    m_file->close();
    delete m_file;
#endif
}

void BachaoDaemon::createGPS()
{
    if (!m_location)
    {   log("inside create gps");
        m_location = QGeoPositionInfoSource::createDefaultSource(this);
        m_location->setPreferredPositioningMethods(QGeoPositionInfoSource::AllPositioningMethods);
        m_location->setUpdateInterval(0);
        // System has some positioning source found
        if (m_location) {
            QObject::connect(m_location, SIGNAL(positionUpdated(QGeoPositionInfo)), this,
                             SLOT(positionUpdated(QGeoPositionInfo)));
            QObject::connect(m_location, SIGNAL(updateTimeout()), this, SLOT(updateTimeout()));
        }
    }
}

void BachaoDaemon::deleteGPS()
{
    emit gpsClosed();
    if (m_location) {
        m_location->stopUpdates();
    }
    delete m_location;
    m_location = 0;
    log("GPS stopped");
}

void BachaoDaemon::startGps()
{
    emit gpsInitialized();
    createGPS();
    m_location->startUpdates();
}

void BachaoDaemon::log(QString str)
{
    qDebug() << str;

#ifdef WRITE_LOG_TO_FILE
    str.append("\n");
    m_outStream << str;
    m_outStream.flush();
#endif
}

int BachaoDaemon::updateTime()
{
    QSettings settings(QDir::homePath()+"/.config/Bachchao/Bachchao-qt.ini", QSettings::IniFormat);
    int locTime = settings.value("User/location", -1).toInt();
    log(QString("loctime is %1").arg(locTime));
    switch(locTime)
    {
    case 0: return 1;
        break;
    case 1: return 6;
        break;
    case 2: return 24;
        break;
    case 3: return 0;
        break;
    }
    return 0;
}

void BachaoDaemon::updateTimeout()
{
    log("Waiting GPS location...");
}

void BachaoDaemon::positionUpdated(QGeoPositionInfo gpsPos)
{
    if(gpsPos.isValid()) {
        QGeoCoordinate cordinate = gpsPos.coordinate();
        QDateTime timestamp = gpsPos.timestamp();
        QString loc = QString("Location info: At %1, location = (%2, %3, %4)").arg(timestamp.toString()).arg(cordinate.latitude())
                .arg(cordinate.longitude()).arg(cordinate.altitude());
        log(loc);
    } else {
        log("Location updated, but not valid");
    }
}
