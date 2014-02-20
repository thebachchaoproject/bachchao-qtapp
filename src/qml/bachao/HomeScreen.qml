// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    signal bachaoPressed
    signal settingsPressed

    ImageButton {
        id: bachaoButton
        anchors {
            top: parent.top; horizontalCenter: parent.horizontalCenter
            topMargin: parent.height*0.1
        }
        width: parent.width; height: width
        source: "qrc:/ui/bachao-button.png"

        onClicked: parent.bachaoPressed()
    }

    ImageButton {
        width: parent.width
        fillMode: Image.PreserveAspectFit
        anchors {
            bottom: parent.bottom; horizontalCenter: parent.horizontalCenter
            bottomMargin: parent.height*0.1
        }
        source: "qrc:/ui/settings-button.png"

        onClicked: parent.settingsPressed()
    }
}
