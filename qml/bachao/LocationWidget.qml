// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    width: parent.width
    height: parent.height
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    property variant locationSetting: Settings.value("User/location", 0)
    Column {
        spacing: 20

        Label {
            id: locationHeader
            anchors.left: parent.left
            anchors.right: parent.right
            color: "#800000"
            anchors.leftMargin: 30
            anchors.topMargin: 20
            elide: Text.ElideRight
            smooth: true
            font.pixelSize: 30
            text: qsTr("Update my Location Every")
        }

        ButtonColumn {
            id: column
            spacing: 20
            exclusive: true
            RadioButton {
                id: button1hr
                text: qsTr("1 hour")
                checked: locationSetting == 0 ? true:false
                onClicked: Settings.setValue("User/location", 0)
            }
            RadioButton {
                id: button6hr
                text: qsTr("6 hours")
                checked: locationSetting == 1 ? true:false
                onClicked: Settings.setValue("User/location", 1)
            }
            RadioButton {
                id: buttonDay
                text: qsTr("Day")
                checked: locationSetting == 2 ? true:false
                onClicked: Settings.setValue("User/location", 2)
            }
            RadioButton {
                id: buttonBachchao
                text: qsTr("Only when press Bachchao")
                checked: locationSetting == 3 ? true:false
                onClicked: Settings.setValue("User/location", 3)
            }
        }
    }
}
