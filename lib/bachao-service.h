#ifndef BACHAOSERVICE_H
#define BACHAOSERVICE_H

#include <libsyncpluginmgr/ClientPlugin.h>
#include <libsyncprofile/SyncResults.h>

class BachaoService : public Buteo::ClientPlugin
{
    Q_OBJECT;
public:
    BachaoService( const QString& aPluginName,
                   const Buteo::SyncProfile& aProfile,
                   Buteo::PluginCbInterface *aCbInterface );

    virtual ~BachaoService();
    virtual bool init();
    virtual bool uninit();
    virtual bool startSync();
//    virtual void abortSync(Sync::SyncStatus aStatus = Sync::SYNC_ABORTED);
//    virtual Buteo::SyncResults getSyncResults() const;
//    virtual bool cleanUp();

public slots:
    virtual void connectivityStateChanged( Sync::ConnectivityType aType,
                                          bool aState );

protected slots:
//    void syncSuccess();
//    void syncFailed();
    void updateLocation();
//private:
//    void updateResults(const Buteo::SyncResults &aResults);
//private:
//    QMap<QString, QString>      iProperties;
//    Buteo::SyncResults          iResults;
};

extern "C" BachaoService* createPlugin( const QString& aPluginName,
                                       const Buteo::SyncProfile& aProfile,
                                       Buteo::PluginCbInterface *aCbInterface );

extern "C" void destroyPlugin( BachaoService *aClient );

#endif // BACHAOSERVICE_H
