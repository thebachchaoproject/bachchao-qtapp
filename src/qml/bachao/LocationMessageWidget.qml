// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.example.bachaocomponents 1.0 as BachaoComponents

FocusScope {
    id: locationMessageWidgetFocusScope
    property QtObject gpsSource
    signal inputPanelClosed

    Rectangle {
        border.width: 1; radius: 10
        anchors.fill: parent
        Row {
            property int textWidth: (width - locationMessageImage.width)/2
            anchors { fill: parent; margins: 10 }

            Image {
                id: locationMessageImage
                height: Math.min(parent.height, 64); sourceSize.height: height
                source: "qrc:/ui/location-message-icon.png"
            }

            TextEdit {
                id: currentlyNearTextInput

                font.pixelSize: 20
                width: parent.textWidth*1.2
                selectByMouse: true

                BachaoComponents.Settings {
                    id: settings
                }

                Component.onCompleted: text = settings.value("messaging/location_update_message", "I am currently near")
                onTextChanged: settings.setValue("messaging/location_update_message", text)

                function stopEditing() {
                    settings.sync();
                    closeSoftwareInputPanel();
                    dummy.focus = true;
                    locationMessageWidgetFocusScope.inputPanelClosed();
                }
            }

            Label {
                id: locationText
                anchors.verticalCenter: parent.verticalCenter
                width: parent.textWidth*0.8
                small: true
                elide: Text.ElideRight

                Component.onCompleted: {
                    text = "Location"
                    locationMessageWidgetFocusScope.gpsSource.dataUpdated.connect(updateLocation);
                    locationMessageWidgetFocusScope.gpsSource.call("emitLastUpdatedData");
                    locationMessageWidgetFocusScope.gpsSource.call("updateLocation");
                }

                function updateLocation(location)
                {
                    locationText.text = location;
                }
            }
        }

        Item { id: dummy }
    }
    onActiveFocusChanged: if (!activeFocus) currentlyNearTextInput.stopEditing()
}
