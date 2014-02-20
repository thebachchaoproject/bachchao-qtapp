// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.example.bachaocomponents 1.0 as BachaoComponents

Rectangle {
    id: videoRecordingRootElement
    color: "grey"
    property QtObject gpsSource

    signal recordingFinished

    Column {
        anchors.fill: parent
        spacing: 32

        Rectangle {
            id: cameraArea
            width: parent.width; height: parent.height - locationBar.height - parent.spacing

            BachaoComponents.VideoRecorder {
                id: videoRecorder
                anchors.fill: parent

                onStoppedRecording: videoRecordingRootElement.recordingFinished();
            }

            ImageButton {
                id: recordingButton

                anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }
                sourceSize.width: 128
                source: "qrc:/ui/stop-recording-button.png"
                onClicked: videoRecorder.stopRecording();
            }
        }

        Rectangle {
            id: locationBar
            width: parent.width; height: 80
            color: "#a60101"

            Row {
                anchors.fill: parent

                Item {
                    id: locationItem
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height; width: height

                    Image {
                        id: locationIcon
                        anchors { fill: parent; margins: 10 }
                        sourceSize.height: height

                        fillMode: Image.PreserveAspectFit
                        source: "qrc:/ui/location-icon.png"
                    }
                }

                Label {
                    id: locationText
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - locationItem.width - videoLengthText.width
                    elide: Text.ElideRight
                    font.pixelSize: parent.height*0.5

                    Component.onCompleted: {
                        text = "Waiting for GPS"
                        videoRecordingRootElement.gpsSource.dataUpdated.connect(updateLocation);
                        videoRecordingRootElement.gpsSource.call("emitLastUpdatedData");
                        videoRecordingRootElement.gpsSource.call("updateLocation");
                    }

                    function updateLocation(location)
                    {
                        locationText.text = location;
                    }
                }

                Text {
                    id: videoLengthText
                    anchors.verticalCenter: parent.verticalCenter
                    text: Math.floor(videoRecorder.duration/60) + ":" + Math.round(videoRecorder.duration%60)
                    font.pixelSize: parent.height*0.6
                    color: "white"
                }
            }
        }
    }

    function startRecording()
    {
        videoRecorder.startRecording();
    }
}
