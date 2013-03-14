// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    width: parent.width
    height: 250
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right 
    property int senderNum: 0
    SelectContactsPage {
        id: selectContactsPage
    }
    function setName(name, num) {
        if(senderNum == 1) {
            contactDetail1.text = name;
            contactNum1.text = "";
            Settings.setValue("Contact1/name", name);
            Settings.setValue("Contact1/number", num);
        }
        if(senderNum == 2) {
            contactDetail2.text = name;
            contactNum2.text = "";
            Settings.setValue("Contact2/name", name);
            Settings.setValue("Contact2/number", num);
        }
        if(senderNum == 3) {
            contactDetail3.text = name;
            contactNum3.text = "";
            Settings.setValue("Contact3/name", name);
            Settings.setValue("Contact3/number", num);
        }

    }

    Label {
        id: contactHeader
        width: parent.width
        height: 20
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#800000"
        anchors.leftMargin: 30
        anchors.topMargin: 20
        elide: Text.ElideRight
        smooth: true
        font.pixelSize: 30
        text: qsTr("Add Contacts")
    }

    Item {
        anchors.top: contactHeader.bottom
        anchors.topMargin: 20
        width: parent.width
        height: 150
        Column {
            spacing: 20
            Item {
                width: screen.width
                height: 40
                anchors.bottomMargin: 10
                MouseArea {
                    anchors.fill: parent
                    Row {
                        x: 30
                        spacing: screen.currentOrientation == 1 ? 110:210
                        Text {
                            id: contactDetail1
                            text: Settings.value("Contact1/name", "Enter Number");
                            font.pixelSize: 30;
                            font.underline: true
                            width: 300

                        }
                        Text {
                            id: contactNum1;
                            text: Settings.contains("Contact1/name") == true? "" :"1"
                            font.pixelSize: 30;
                        }
                    }
                    onClicked: {
                        senderNum = 1;
                        pageStack.push(selectContactsPage)
                        selectContactsPage.contactSelected.connect(setName)
                    }
                }
            }
            Item {
                width: screen.width
                height: 40
                MouseArea {
                    anchors.fill: parent
                    Row {
                        x: 30
                        spacing: screen.currentOrientation == 1 ? 110:210
                        Text {
                            id: contactDetail2
                            text: Settings.value("Contact2/name", "Enter Number");
                            font.pixelSize: 30
                            font.underline: true
                            width: 300
                        }
                        Text {
                            id: contactNum2;
                            text: Settings.contains("Contact2/name") == true? "" :"2"
                            font.pixelSize: 30;
                        }
                    }
                    onClicked: {
                        senderNum = 2;
                        pageStack.push(selectContactsPage)
                        selectContactsPage.contactSelected.connect(setName)
                    }
                }
            }
            Item {
                width: screen.width
                height: 40
                MouseArea {
                    anchors.fill: parent
                    Row {
                        x: 30
                        spacing: screen.currentOrientation == 1 ? 110:210
                        Text {
                            id: contactDetail3
                            text: Settings.value("Contact3/name", "Enter Number");
                            font.pixelSize: 30
                            font.underline: true
                            width: 300
                        }
                        Text {
                            id: contactNum3;
                            text: Settings.contains("Contact3/name") == true? "" :"3"
                            font.pixelSize: 30;
                        }
                    }
                    onClicked: {
                        senderNum = 3;
                        pageStack.push(selectContactsPage)
                        selectContactsPage.contactSelected.connect(setName)
                    }
                }
            }
        }
    }
}
