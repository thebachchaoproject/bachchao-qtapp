// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    width: parent.width
    height: 110
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    Column {
        id: videoColumn
        spacing: 20
        Label {
            id: videoHeader
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 30
            anchors.topMargin: 20
            elide: Text.ElideRight
            smooth: true
            font.pixelSize: 30
            text: qsTr("Video Streaming")
        }

        CheckBox {
            id: checkbox
            anchors.leftMargin: 30
            anchors.topMargin: 20
            text: qsTr("Stop Streaming on Double Tap")
        }
    }
    CheckBox {
        id: videoStreaming
        anchors.left: videoColumn.right
        anchors.leftMargin: screen.currentOrientation == 1 ? 40:140
        checked: Settings.value("User/VideoStreaming",true)
        onCheckedChanged: Settings.setValue("User/VideoStreaming", checked)
    }
    //ADD Toggle button
}
