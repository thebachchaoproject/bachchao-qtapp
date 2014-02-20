#include "bachao-daemon.h"

#include "gpsdatasource.h"

BachaoDaemon *BachaoDaemon::m_instance = 0;

BachaoDaemon::BachaoDaemon(QObject *parent) :
    QObject(parent)
{
    m_inputSources.append(new GpsDataSource(this));
}

void BachaoDaemon::startSources()
{
    foreach (AbstractInputSource *source, m_inputSources) {
        source->start();
    }
}

BachaoDaemon::~BachaoDaemon()
{
}

BachaoDaemon *BachaoDaemon::instance()
{
    if (!m_instance) {
        m_instance = new BachaoDaemon;
    }
    return m_instance;
}

AbstractInputSource *BachaoDaemon::findSource(const QString &sourceName)
{
    foreach (AbstractInputSource *source, m_inputSources) {
        if (source->sourceName() == sourceName)
            return source;
    }
}

QList<AbstractInputSource*> BachaoDaemon::sources()
{
    return m_inputSources;
}
