// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    height: 100
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    color: "#F5F5DC"
    property alias text: header.text
    Label {
        id: header
        width: parent.width
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#800000"
        anchors.leftMargin: 30
        anchors.topMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        elide: Text.ElideRight
        smooth: true
        font.pixelSize: 50
    }
}
