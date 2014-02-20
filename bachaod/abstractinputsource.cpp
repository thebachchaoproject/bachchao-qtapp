#include "abstractinputsource.h"

class AbstractInputSource::Private
{
public:
    QString lastUpdateData;
};

AbstractInputSource::AbstractInputSource(QObject *parent) :
    QObject(parent),
    d(new Private)
{
    connect(this, SIGNAL(dataUpdated(QString)), SLOT(storeLastUpdatedData(QString)));
}

void AbstractInputSource::reloadConfig()
{
}

void AbstractInputSource::storeLastUpdatedData(const QString &data)
{
    d->lastUpdateData = data;
}

void AbstractInputSource::emitLastUpdatedData()
{
    emit dataUpdated(lastUpdatedData());
}

QString AbstractInputSource::lastUpdatedData() const
{
    return d->lastUpdateData;
}
