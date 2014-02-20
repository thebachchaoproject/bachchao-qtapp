// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.example.bachaocomponents 1.0 as BachaoComponents

Row {
    id: locationDurationSelectorRootElement
    property int itemHeight: height - 10
    property QtObject gpsSource

    spacing: 10

    ImageButton {
        id: locationTabLeftButton
        height: parent.itemHeight; sourceSize.height: height
        source: "qrc:/ui/location-tab-left.png"
        onClicked: locationDurationLabel.previous()
        onPressAndHold: decreaseTimer.start()
        onReleased: decreaseTimer.stop()

        Timer {
            id: decreaseTimer
            interval: 100; repeat: true
            onTriggered: locationDurationLabel.duration--
        }
    }

    Image {
        sourceSize.width: parent.width - locationTabLeftButton.width - locationTabLeftButton.width - parent.spacing*2
        sourceSize.height: parent.itemHeight
        source: "qrc:/ui/location-tab.png"

        Label {
            id: locationDurationLabel
            property int duration: 0
            property int durationValue: intervalValues.get(duration).value

            anchors.centerIn: parent
            small: true; color: "white"
            text: durationValue === 0 ? "never" : durationValue + " hours"

            BachaoComponents.Settings {
                id: settings
            }

            Timer {
                id: timer
                interval: 1000
                onTriggered: {
                    settings.setValue("location/interval", locationDurationLabel.durationValue);
                    settings.setValue("location/intervalIndex", locationDurationLabel.duration);
                    settings.sync();
                    locationDurationSelectorRootElement.gpsSource.call("reloadConfig");
                }
            }

            Component.onCompleted: duration = settings.value("location/intervalIndex", 0)
            onDurationValueChanged: timer.restart();

            function next() {
                duration = (duration == intervalValues.count - 1 ? 0 : duration+1)
            }
            function previous() {
                duration = (duration == 0 ? intervalValues.count - 1 : duration-1)
            }
        }
    }

    ImageButton {
        id: locationTabRightButton
        height: parent.itemHeight; sourceSize.height: height
        source: "qrc:/ui/location-tab-right.png"
        onClicked: locationDurationLabel.next()
        onPressAndHold: increaseTimer.start()
        onReleased: increaseTimer.stop()

        Timer {
            id: increaseTimer
            interval: 100; repeat: true
            onTriggered: locationDurationLabel.duration++
        }
    }

    ListModel {
        id: intervalValues
        ListElement { value: 0 }
        ListElement { value: 1 }
        ListElement { value: 2 }
        ListElement { value: 6 }
        ListElement { value: 12 }
        ListElement { value: 24 }
    }
}
