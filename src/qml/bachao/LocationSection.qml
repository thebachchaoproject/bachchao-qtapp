// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

FocusScope {
    id: locationSectionFocusScope
    property QtObject gpsSource

    signal inputPanelClosed

    Column {
        anchors.fill: parent

        Row {
            id: locationHeader
            width: parent.width; height: locationLabel.height

            Image {
                height: parent.height - 10
                sourceSize.height: height
                source: "qrc:/ui/location-icon.png"
            }

            Label {
                id: locationLabel
                text: "LOCATION UPDATE"
            }
        }

        Item {
            height: parent.height - locationHeader.height; width: parent.width

            Column {
                property int rowHeight: height/2 - spacing
                anchors { fill: parent; margins: 10 }
                spacing: 10

                Row {
                    width: parent.width; height: parent.rowHeight*0.8
                    spacing: 10

                    Label {
                        id: updateLocationText
                        text: "EVERY:"
                    }

                    Item {
                        width: parent.width - updateLocationText.width - parent.spacing
                        height: parent.height

                        LocationDurationSelector {
                            anchors { fill: parent; margins: 5 }
                            gpsSource: locationSectionFocusScope.gpsSource
                        }
                    }
                }

                Item {
                    width: parent.width; height: parent.rowHeight*1.2

                    LocationMessageWidget {
                        id: locationMessageWidget
                        anchors { fill: parent; margins: 5 }
                        gpsSource: locationSectionFocusScope.gpsSource
                        onInputPanelClosed: locationSectionFocusScope.inputPanelClosed()
                    }
                }
            }
        }
    }

    onActiveFocusChanged: if (!activeFocus) locationMessageWidget.focus = false
}
