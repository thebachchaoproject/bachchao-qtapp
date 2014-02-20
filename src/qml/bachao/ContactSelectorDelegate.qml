// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: contactSelectorDelegateRoot
    property alias contactName: contactName.text
    property alias contactNumber: phoneNumber.text

    color: "black"
    Row {
        anchors { fill: parent; margins: 5 }
        scale: contactSelectorDelegateMouseArea.pressed ? 1.1 : 1

        Rectangle {
            id: colorRect
            height: parent.height; width: height
            color: "red"; radius: 5
        }

        Item {
            height: parent.height; width: parent.width - colorRect.width
            Text {
                id: contactName
                anchors { fill: parent; margins: 5 }
                font.pixelSize: height*0.8
                elide: Text.ElideRight
                text: display
                color: "white"
            }
        }

        Text {
            id: phoneNumber; visible: false
            text: contact.phoneNumber.number
        }
    }

    MouseArea {
        id: contactSelectorDelegateMouseArea
        anchors.fill: parent
        onClicked: contactSelectorDelegateRoot.ListView.view.currentIndex = index
    }
}
