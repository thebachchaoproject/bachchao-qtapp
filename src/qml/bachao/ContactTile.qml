// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Image {
    property alias text: contactNameText.text
    signal clicked
    width: height; sourceSize.width: width
    source: "qrc:/ui/contact-avatar.png"

    Text {
        id: contactNameText
        anchors {
            bottom: parent.bottom; horizontalCenter: parent.horizontalCenter
        }
        color: "white"
        font.pixelSize: 14
        elide: Text.ElideRight
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
