// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMobility.contacts 1.1 as QtContacts
import com.example.bachaocomponents 1.0 as BachaoComponents

FocusScope {
    id: root
    signal contactSelected

    property string contactIndex

    BachaoComponents.Settings {
        id: settings
    }

    Rectangle {
        anchors.fill: parent
        Column {
            anchors.fill: parent

            ImageButton {
                id: contactsHeaderImage
                width: parent.width; sourceSize.width: width
                source: "qrc:/ui/generic-header.png"
                text: selectedContactWidget.contactName === "" ? "ADD CONTACT" : "REPLACE CONTACT"
                font.pixelSize: height*0.6

                ImageButton {
                    anchors {
                        top: parent.top; bottom: parent.bottom
                        left: parent.left; margins: 5
                    }
                    sourceSize.height: height
                    source: "qrc:/ui/return-from-settings-icon.png"

                    onClicked: {
                        root.contactSelected();
                        contactsListView.currentIndex = -1;
                    }
                }
            }

            SelectedContactWidget {
                id: selectedContactWidget
                width: parent.width; finalHeight: 96
                contactName: contactsListView.currentItem ? contactsListView.currentItem.contactName : settings.value("messaging/location_update_name"+root.contactIndex, "")
                onContactNameChanged: {
                    if (contactsListView.currentIndex === -1) return;
                    settings.setValue("messaging/location_update_name"+root.contactIndex, contactName);
                    settings.sync();
                }
            }

            Text {
                id: selectedContactNumber; visible: false
                property string initialContactNumber: settings.value("messaging/location_update_number"+root.contactIndex, "")

                text: contactsListView.currentItem ? contactsListView.currentItem.contactNumber : initialContactNumber
                onTextChanged: {
                    if (contactsListView.currentIndex === -1) return;
                    settings.setValue("messaging/location_update_number"+root.contactIndex, text);
                    settings.sync();
                }
            }

            ListView {
                id: contactsListView
                property bool initDone: false
                width: parent.width
                height: parent.height - selectedContactWidget.height - contactsHeaderImage.height

                snapMode: ListView.SnapToItem
                currentIndex: -1
                clip: true; spacing: 4
                model: QtContacts.ContactModel {
                    sortOrders: QtContacts.SortOrder {
                        detail: QtContacts.ContactDetail.Name
                        field: QtContacts.Name.FirstName
                        direction: Qt.AscendingOrder
                    }
                    filter: QtContacts.DetailFilter {
                        detail: QtContacts.ContactDetail.PhoneNumber
                        field: QtContacts.PhoneNumber.MessagingCapable
                    }
                }

                delegate: ContactSelectorDelegate {
                    width: ListView.view.width; height: 64
                }

                section {
                    property: "display"
                    criteria: ViewSection.FirstCharacter
                }

                onCountChanged: if (!initDone && count > 0) { fastScroll.update(); initDone = true }
            }
        }
    }

    FastScroll { id: fastScroll; listView: contactsListView }
}
