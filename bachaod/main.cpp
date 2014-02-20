#include <QtCore/QCoreApplication>

#include "bachaodaemonserviceinterface.h"
#include "bachao-daemon.h"

#include <QtCore/QFile>
#include <QtCore/QDateTime>
#include <QtDBus/QDBusConnection>
#include <QtCore/QTextStream>
#include <QtCore/QDebug>

#ifdef WRITE_LOG_TO_FILE

void clearLogfile()
{
    QFile::remove("/tmp/bachao.log");
}

void myMessageOutput(QtMsgType type, const char *msg)
{
    QFile logFile("/tmp/bachao.log");
    logFile.open(QIODevice::WriteOnly | QIODevice::Text  | QIODevice::Append);
    QTextStream log(&logFile);

    log << QDateTime::currentDateTime().toString() << ": ";
    switch (type) {
    case QtDebugMsg:
        log << "Debug: " << msg;
        break;
    case QtWarningMsg:
        log << "Warning: " << msg;
        break;
    case QtCriticalMsg:
        log << "Critical: " << msg;
        break;
    case QtFatalMsg:
        log << "Fatal: " << msg;
        abort();
    }
    log << "\n";
    log.flush();
    logFile.close();
}
#endif

int main(int argc, char *argv[])
{
#ifdef WRITE_LOG_TO_FILE
    clearLogfile();
    qInstallMsgHandler(myMessageOutput);
#endif

    qDebug() << "Starting daemon...";
    QCoreApplication a(argc, argv);
    QCoreApplication::setOrganizationName("Bachchao");
    QCoreApplication::setApplicationName("BachchaoMobile");

    // Create daemon
    BachaoDaemon::instance()->startSources();

    //Register D-Bus interfaces
    BachaoDaemonServiceInterface interface;

    return a.exec();
}
