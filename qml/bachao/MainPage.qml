// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.0
import com.nokia.meego 1.0
//import MyLibrary 1.0

Page {
    anchors.fill: parent;

    Button {
        id: helpButton
        text: "Help"
        x: screen.currentOrientation == 1 ? 50: 100
        y: screen.currentOrientation == 1 ? 100: 50
        width: screen.currentOrientation == 1 ? 370: 650
        height: screen.currentOrientation == 1 ? 400: 200
        onClicked: pageStack.push(cameraPage);
    }

    Button{
        x: screen.currentOrientation == 1 ? 50: 500
        y: screen.currentOrientation == 1 ? 570: 300
        width: screen.currentOrientation == 1 ? 370: 300
        id: settingsButton
        text:" Settings"
        onClicked: pageStack.push(settingsPage);
    }

    tools: ToolBarLayout {
        Button {
            id:cancelButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Cancel"
            Timer {
                 interval: 30000; running: true;
                 onTriggered: cancelButton.enabled = false
            }
        }
    }
}
