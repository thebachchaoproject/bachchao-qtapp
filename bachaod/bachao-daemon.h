#ifndef BACHAODAEMON_H
#define BACHAODAEMON_H

#include <QtCore/QObject>

#include "abstractinputsource.h"

class BachaoDaemon: public QObject
{
Q_OBJECT

public:
    static BachaoDaemon *instance();
    virtual ~BachaoDaemon();

    void startSources();
    AbstractInputSource *findSource(const QString &sourceName);
    QList<AbstractInputSource*> sources();

private:
    BachaoDaemon(QObject *parent = 0);

    static BachaoDaemon *m_instance;
    QList<AbstractInputSource*> m_inputSources;
};


#endif // BACHAODAEMON_H
