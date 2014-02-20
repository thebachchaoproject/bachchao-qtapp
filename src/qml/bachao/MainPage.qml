// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import com.example.bachaocomponents 1.0 as BachaoComponents

Page {
    orientationLock: PageOrientation.LockPortrait

    Rectangle {
        id: rootElement
        anchors.fill: parent

        BachaoComponents.BachaoDaemonConnection {
            id: commonGpsSource
            sourceName: "gps"
        }

        HomeScreen {
            id: homeScreen
            width: parent.width; height: parent.height
            anchors { left: parent.left; top: parent.top }

            onBachaoPressed: rootElement.state = "video"
            onSettingsPressed: rootElement.state = "settings"
        }

        VideoRecording {
            id: videoRecording
            width: parent.width; height: parent.height
            anchors { left: parent.right; top: parent.top }
            gpsSource: commonGpsSource

            onRecordingFinished: rootElement.state = ""
        }

        SettingsPage {
            id: settingsPage
            width: parent.width; height: parent.height
            anchors { left: parent.right; top: parent.top }
            gpsSource: commonGpsSource

            onBackPressed: rootElement.state = ""
        }

        states: [
            State {
                name: "video"
                AnchorChanges { target: homeScreen; anchors.left: parent.right }
                AnchorChanges { target: settingsPage; anchors.left: parent.right }
                AnchorChanges { target: videoRecording; anchors.left: parent.left }
                StateChangeScript {
                    script: {
                        commonGpsSource.call("sendEmergency");
                        videoRecording.startRecording();
                    }
                }
            },
            State {
                name: "settings"
                AnchorChanges { target: homeScreen; anchors.left: parent.right }
                AnchorChanges { target: videoRecording; anchors.left: parent.right }
                AnchorChanges { target: settingsPage; anchors.left: parent.left }
            }
        ]

        transitions: [ Transition { AnchorAnimation { duration: 200 } } ]
    }
}
