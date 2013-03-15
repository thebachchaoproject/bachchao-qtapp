// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.contacts 1.1

Page {
    id: selectContactsPage
    width: parent.width
    height: 250
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    signal contactSelected(string name, string num)

    Row {
        id: buttonRow
        x: 20
        y: 20
        width: parent.width
        Button {
            id: cancel
            width: 200
            text: "Cancel"
            onClicked: { pageStack.pop() }
        }
    }
    ListView {
        id:  contactList
        anchors.top: buttonRow.bottom
        anchors.topMargin: 20
        x:40
        width: screen.width
        height: 1000
        model: ContactModel {
           sortOrders: SortOrder{
            detail: ContactDetail.Name
            field: Name.FirstName
            direction: Qt.AscendingOrder
           }
        }
        delegate: Item {
            height: 50
            property variant myData: model
            width: parent.width
            MouseArea {
                anchors.fill: parent
                Text {
                    font.pixelSize: 30
                    font.bold: true
                    text: model.contact.name.firstName +" " + model.contact.name.lastName
                }
                onClicked: {
                    contactList.currentIndex = index
                    var number = contactList.currentItem.myData.contact.phoneNumber.number
                    var isContactAdded = false
                    for (var i = 1; i <= 3; i++)
                    {
                        var key = "Contact"+i+"/number";
                        if (Settings.value(key) == number)
                        {
                            messageBox.show("Contact already added");
                            isContactAdded  = true;
                        }
                    }
                    if (!isContactAdded) {
                        var fullname = model.contact.name.firstName
                        if (model.contact.name.lastName)
                            fullname=  fullname+ " " + model.contact.name.lastName
                        contactSelected(fullname, number)
                    }
                }
            }
        }
    }

    onContactSelected : {pageStack.pop()}
}
