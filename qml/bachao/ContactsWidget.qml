// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    width: parent.width
    height: 250
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

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
                width: parent.width
                height: 40
                anchors.bottomMargin: 10
                MouseArea {
                    anchors.fill: parent
                    Row {
                        x: 30
                        spacing: screen.currentOrientation == 1 ? 110:210
                        Text {
                            text: "Enter Number";
                            font.pixelSize: 30;
                            font.underline: true
                            width: 300

                        }
                        Text {id: contactNum; text: "1"; font.pixelSize: 30;}
                    }
                    onClicked: {console.debug("ddddddddddddddd");}
                }
            }
            Item {
                width: parent.width
                height: 40
                MouseArea {
                    anchors.fill: parent
                    Row {
                        x: 30
                        spacing: screen.currentOrientation == 1 ? 110:210
                        Text {
                            text: "Enter Number";
                            font.pixelSize: 30
                            font.underline: true
                            width: 300
                        }
                        Text {text: "2"; font.pixelSize: 30;}
                    }
                }
            }
            Item {
                width: parent.width
                height: 40
                MouseArea {
                    anchors.fill: parent
                    Row {
                        x: 30
                        spacing: screen.currentOrientation == 1 ? 110:210
                        Text {
                            text: "Enter Number";
                            font.pixelSize: 30
                            font.underline: true
                            width: 300
                        }
                        Text {text: "3"; font.pixelSize: 30;}
                    }
                }
            }
        }
    }
}
