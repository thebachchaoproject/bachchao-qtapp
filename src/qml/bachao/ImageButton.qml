// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    property alias text: imageButtonText.text
    property alias textColor: imageButtonText.color
    property alias font: imageButtonText.font
    signal clicked
    signal pressAndHold
    signal released
    scale: imageButtonMouseArea.pressed ? 1.2 : 1

    MouseArea {
        id: imageButtonMouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
        onPressAndHold: parent.pressAndHold()
        onReleased: parent.released()
    }

    Text {
        id: imageButtonText
        anchors.centerIn: parent
        color: "#970000"
        visible: text != ""
        font.pixelSize: parent.height*0.8
    }

    Behavior on scale { NumberAnimation { duration: 100 } }
}
