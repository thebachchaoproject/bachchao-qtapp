// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {
    id: messageBox
    width: parent.width
    height: 250
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    visible: false
    color: "black"
    function show(displayText)
    {
        timer.running = true
        label.text = displayText;
        visible = true
    }
    Label {
        id: label
        color: "white"
        font.pixelSize: 30
        anchors.centerIn: parent
    }

    Timer {
         id : timer
         interval: 1000; running: false;
         onTriggered: messageBox.visible = false
    }
}

