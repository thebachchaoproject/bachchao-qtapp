// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: settingsRootElement
    property QtObject gpsSource
    signal backPressed

    focus: true

    Column {
        id: settingsColumn
        property int sectionHeight: (height - settingsHeaderImage.height)/3
        anchors.fill: parent

        ImageButton {
            id: settingsHeaderImage
            width: parent.width; sourceSize.width: width
            source: "qrc:/ui/settings-header.png"

            ImageButton {
                anchors {
                    top: parent.top; bottom: parent.bottom
                    left: parent.left; margins: 5
                }
                visible: settingsRootElement.activeFocus
                sourceSize.height: height
                source: "qrc:/ui/return-from-settings-icon.png"

                onClicked: {
                    settingsRootElement.focus = true;
                    settingsRootElement.backPressed();
                }
            }

            onClicked: settingsRootElement.focus = true
        }

        Item {
            width: parent.width; height: parent.sectionHeight
            visible: !messagingSection.activeFocus && !locationSection.activeFocus

            ContactsSection {
                id: contactsSection
                anchors { fill: parent; margins: 20 }
                onContactSelectionRequired: {
                    settingsPageContactSelector.contactIndex = contactIndex;
                    settingsPageContactSelector.state = "shown";
                }
            }
        }

        Item {
            width: parent.width
            height: locationSection.activeFocus ? parent.height*0.75 : parent.sectionHeight
            visible: !messagingSection.activeFocus

            LocationSection {
                id: locationSection
                anchors { fill: parent; margins: 5 }
                z: 1
                gpsSource: settingsRootElement.gpsSource
                onInputPanelClosed: settingsRootElement.focus = true
            }
        }

        Item {
            width: parent.width
            height: messagingSection.activeFocus ? parent.height/2 : parent.sectionHeight
            visible: !locationSection.activeFocus

            MessagingSection {
                id: messagingSection
                anchors { fill: parent; margins: 20 }
                z: 1
                onInputPanelClosed: settingsRootElement.focus = true
            }
        }

        MouseArea {
            width: parent.width
            height: settingsRootElement.activeFocus ? 0 : parent.height/2
            onClicked: settingsRootElement.focus = true
        }
    }

    ContactSelector {
        id: settingsPageContactSelector
        anchors { top: parent.bottom; left: parent.left; right: parent.right }
        height: parent.height
        onContactSelected: {
            state = "";
            contactsSection.updateContactsModel();
        }

        states : [
            State {
                name: "shown"
                AnchorChanges { target: settingsPageContactSelector; anchors.top: parent.top }
            }
        ]

        transitions: [ Transition { AnchorAnimation { duration: 200 } } ]
    }
}
