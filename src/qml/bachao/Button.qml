// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property alias text: buttonText.text
    signal clicked

    radius: 10
    border.width: 1

    color: buttonMouseArea.pressed ? "red" : "white"

    Text {
        id: buttonText
        anchors.centerIn: parent
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
