// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.example.bachaocomponents 1.0 as BachaoComponents

Rectangle {
    id: contactsSection
    signal contactSelectionRequired(string contactIndex)

    Column {
        anchors.fill: parent

        Row {
            id: contactsHeader
            width: parent.width; height: contactsLabel.height

            Image {
                height: parent.height - 10
                sourceSize.height: height
                source: "qrc:/ui/contacts-icon.png"
            }

            Label {
                id: contactsLabel
                text: "CONTACTS"
            }
        }

        Rectangle {
            height: parent.height - contactsHeader.height; width: parent.width

            ListView {
                property int delegateWidth: width/3

                anchors.centerIn: parent
                width: parent.width * 0.8; height: delegateWidth

                interactive: false
                orientation: ListView.Horizontal
                spacing: 10
                model: contactsModel
                delegate: ContactTile {
                    width: ListView.view.width/3.5; sourceSize.width: width
                    text: display.toUpperCase().split(" ")[0];
                    onClicked: contactsSection.contactSelectionRequired(index)
                }
            }
        }
    }

    BachaoComponents.Settings {
        id: settings
    }

    ListModel {
        id: contactsModel
    }

    function updateContactsModel() {
        contactsModel.clear();
        for (var i=0; i<3; i++) {
            contactsModel.append({"display": settings.value("messaging/location_update_name"+i, "add")});
        }
    }

    Component.onCompleted: updateContactsModel()
}
