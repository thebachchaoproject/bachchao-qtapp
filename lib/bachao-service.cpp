#include "bachao-service.h"
#include "location.h"

#include <libsyncpluginmgr/PluginCbInterface.h>
#include <LogMacros.h>
#include <QTimer>
#include <QDateTime>
#include <QMap>
#include <QUrl>

extern "C" BachaoService* createPlugin(const QString& aPluginName,
                                       const Buteo::SyncProfile& aProfile,
                                       Buteo::PluginCbInterface *aCbInterface)
{
    return new BachaoService(aPluginName, aProfile, aCbInterface);
}

extern "C" void destroyPlugin(BachaoService* aClient)
{
    delete aClient;
}

BachaoService::BachaoService(const QString& aPluginName,
                const Buteo::SyncProfile& aProfile,
                Buteo::PluginCbInterface *aCbInterface) :
                ClientPlugin(aPluginName, aProfile, aCbInterface)
{
   FUNCTION_CALL_TRACE;
}

BachaoService::~BachaoService()
{
        FUNCTION_CALL_TRACE;
}

bool BachaoService::init()
{
    FUNCTION_CALL_TRACE;

   //The sync profiles can have some specific key/value pairs this info
   //can be accessed by this method.
//   iProperties = iProfile.allNonStorageKeys();

   //return false - if error
   //syncfw will call this method first if the plugin is able to initialize properly
   //and its ready for sync it should return 'true' in case of any error return false.
   return true;
}

bool BachaoService::uninit()
{
   FUNCTION_CALL_TRACE;
   // called before unloading the plugin , the plugin should clean up
   return true;
}

bool BachaoService::startSync()
{
   FUNCTION_CALL_TRACE;

   // This method is called after init(), the plugin is expected to return
   // either true or false based on if the sync was started successfully or
   // it failed for some reason
   //call appropriate slots based on the status of operation success/failed...
   //updateFeed Its just a helper function.
   QTimer::singleShot(1, this, SLOT(updateLocation()));

   return true;
}

//void EventsExample::abortSync(Sync::SyncStatus aStatus)
//{
//   FUNCTION_CALL_TRACE;
//   Q_UNUSED(aStatus);
//   // This method is called if used cancels the
//   // sync in between , with the applet use case
//   // it should not ideally happen as there is no UI
//   // in case of device sync and accounts sync we have
//   // a cancel button
//}

//bool EventsExample::cleanUp()
//{
//   FUNCTION_CALL_TRACE;

//   // this method is called in case of account being deleted
//   // or the profile being deleted from UI in case of applet
//   // it will not be called ....need to check as if there
//   // can be any use case for this
//   return true;
//}

//Buteo::SyncResults EventsExample::getSyncResults() const
//{
//        FUNCTION_CALL_TRACE;
//        return iResults;
//}

void BachaoService::connectivityStateChanged(Sync::ConnectivityType aType,
                bool aState)
{
   FUNCTION_CALL_TRACE;
   // This function notifies of the plugin of any connectivity related state changes
   LOG_DEBUG("Received connectivity change event:" << aType << " changed to " << aState);
   if ((aType == Sync::CONNECTIVITY_INTERNET) && (aState == false)) {
       // Network disconnect!!
   }
}

//void BachaoService::syncSuccess()
//{
//   FUNCTION_CALL_TRACE;
//   updateResults(Buteo::SyncResults(QDateTime::currentDateTime(), Buteo::SyncResults::SYNC_RESULT_SUCCESS, Buteo::SyncResults::NO_ERROR));
//   //Notify Sync FW of result - Now sync fw will call uninit and then will unload plugin
//   emit success(getProfileName(), "Success!!");
//}

//void BachaoService::syncFailed()
//{
//   FUNCTION_CALL_TRACE;
//   //Notify Sync FW of result - Now sync fw will call uninit and then will unload plugin
//   updateResults(Buteo::SyncResults(QDateTime::currentDateTime(),
//                 Buteo::SyncResults::SYNC_RESULT_FAILED, Buteo::SyncResults::ABORTED));
//   emit error(getProfileName(), "Error!!", Buteo::SyncResults::SYNC_RESULT_FAILED);
//}

//void BachaoService::updateResults(const Buteo::SyncResults &aResults)
//{
//   FUNCTION_CALL_TRACE;
//   iResults = aResults;
//   iResults.setScheduled(true);
//}

void BachaoService::updateLocation()
{
    FUNCTION_CALL_TRACE;

    Location locationObj;


//   QMap <QString, QVariant> parameters;
//   //Test parameters

//   bool success = false;
//   //Ok assuming that we now have the data that needs to be updated to event feed
//   qlonglong id  = MEventFeed::instance()->addItem(QString("icon-m-transfer-sync"),
//                           QString("EventsExample"),
//                           QString("Event Feed updated"),
//                           QStringList(),
//                           QDateTime::currentDateTime(),
//                           QString(),
//                           false,
//                           QUrl(),
//                           QString("SyncFW-event-example"),
//                           QString("SyncFW and event feed example app"));
//   if (id != -1) {
//            success = true;
//   }
//   if(success)
//       syncSuccess();
//   else
//        syncFailed();
}
