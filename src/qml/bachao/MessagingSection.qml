// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.example.bachaocomponents 1.0 as BachaoComponents

FocusScope {
    id: messagingFocusScope
    signal inputPanelClosed

    Column {
        anchors.fill: parent

        Row {
            id: messagingHeader
            width: parent.width; height: messagingLabel.height

            Image {
                height: parent.height - 10
                sourceSize.height: height
                source: "qrc:/ui/message-icon.png"
            }

            Label {
                id: messagingLabel
                text: "CUSTOM MESSAGE"
            }
        }

        Item {
            height: parent.height - messagingHeader.height; width: parent.width

            Rectangle {
                anchors { fill: parent; margins: 10 }
                border.width: 1; radius: 10
                clip: true

                TextEdit {
                    id: customMessageTextEdit
                    anchors { fill: parent; margins: 10 }
                    clip: true

                    font.pixelSize: 20
                    selectByMouse: true
                    wrapMode: TextEdit.Wrap

                    BachaoComponents.Settings {
                        id: settings
                    }

                    Component.onCompleted: text = settings.value("messaging/custom_message", "Type custom message here")
                    onTextChanged: settings.setValue("messaging/custom_message", text)

                    function stopEditing() {
                        settings.sync();
                        closeSoftwareInputPanel();
                        dummy.focus = true;
                        messagingFocusScope.inputPanelClosed();
                    }
                }
            }
        }
    }

    Item { id: dummy }
    onActiveFocusChanged: if (!activeFocus) customMessageTextEdit.stopEditing()
}
