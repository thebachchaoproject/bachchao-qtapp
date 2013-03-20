// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    width: parent.width
    height: 250
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    function onDoneClicked() {
        if (nameText.text == "") {
            messageBox.show("Enter Name");
            return;
        }
        if (numberText.text == "") {
            messageBox.show("Enter Phone Number");
            return;
        }
        else if(numberText.text.length < 10)
            messageBox.show("Phone number should be 10 digits");
        if (emailText.text == "") {
            messageBox.show("Enter Email");
            return;
        }
        //TODO: add check for valid email
        var number = numberText.text
        var isContactAdded = false
        for (var i = 1; i <= 3; i++)
        {
            var key = "Contact"+i+"/number";
            if (Settings.value(key) == number)
            {
                messageBox.show("Contact already added");
                isContactAdded  = true;
            }
        }
        if (!isContactAdded) {
            var fullname = nameText.text
            var details = {'name': fullname, 'number': number, 'email': emailText.text}
            contactWidget.setContactDetails(details)
            pageStack.pop(settingsPage)
            nameText.text="";
            numberText.text="";
            emailText.text="";
        }

    }
    Column {
        spacing: 10
        x: 20; y: 40
        Label { text: "Name"; font.pixelSize: 30}
        Rectangle {
            width: 420; height: 40; border.color: "black"; border.width: 2
            TextInput
            { id: nameText; x: 5; cursorVisible: true; width: parent.width; color: "blue";
              font.pixelSize: 30;
              Keys.onReturnPressed: closeSoftwareInputPanel()
            }
        }
        Label { text: "Phone Number"; font.pixelSize: 30}
        Rectangle {
            width: 420; height: 40; border.color: "black"; border.width: 2
            TextInput
            { id: numberText; x: 5; width: parent.width; color: "blue"; font.pixelSize: 30;
              inputMethodHints: Qt.ImhFormattedNumbersOnly
              Keys.onReturnPressed: closeSoftwareInputPanel()
            }
        }
        Label { text: "Email Id"; font.pixelSize: 30}
        Rectangle {
            width: 420; height: 40; border.color: "black"; border.width: 2
            TextInput
            { id: emailText; x: 5; width: parent.width; color: "blue"; font.pixelSize: 30
              Keys.onReturnPressed: closeSoftwareInputPanel()
            }
        }
    }

    tools: ToolBarLayout {
        Item {
            width: 380
            height: 32
            anchors.horizontalCenter: parent.horizontalCenter
            ToolButton {
                id:doneButton
                text: "Done"
                onClicked: onDoneClicked()
            }
            ToolButton {
                id:cancelButton
                anchors.left: doneButton.right
                text: "Cancel"
                onClicked: {
                    pageStack.pop()
                    nameText.text="";
                    numberText.text="";
                    emailText.text="";
                }
            }
        }
    }
}
