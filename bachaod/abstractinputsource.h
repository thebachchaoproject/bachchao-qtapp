#ifndef ABSTRACTINPUTSOURCE_H
#define ABSTRACTINPUTSOURCE_H

#include <QtCore/QObject>

class AbstractInputSource : public QObject
{
    Q_OBJECT
public:
    explicit AbstractInputSource(QObject *parent = 0);
    virtual QString sourceName() = 0;
    QString lastUpdatedData() const;

signals:
    void dataUpdated(const QString &data);
    
public slots:
    virtual void start() = 0;
    virtual void stop() = 0;

    virtual void reloadConfig();
    void emitLastUpdatedData();

private slots:
    void storeLastUpdatedData(const QString &data);

private:
    class Private;
    Private * const d;

};

#endif // ABSTRACTINPUTSOURCE_H
