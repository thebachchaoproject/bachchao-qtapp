// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    id: selectedContactWidgetRootItem
    property string contactName
    property int finalHeight: 0
    height: contactTile.text === "" ? 0 : finalHeight
    clip: true

    Label {
        anchors {
            left: parent.left; right: contactTile.left
            verticalCenter: parent.verticalCenter
        }
        text: "ASSIGNED CONTACT:"
    }

    ContactTile {
        id: contactTile
        text: selectedContactWidgetRootItem.contactName.split(" ")[0]
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right; margins: 5
        }
        height: parent.height*0.9
    }

    Behavior on height { NumberAnimation { duration: 200 } }
}
