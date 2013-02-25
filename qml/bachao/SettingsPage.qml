// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMultimediaKit 1.1
import com.nokia.meego 1.0

Page {
    id: settingsPage
    anchors.fill: parent;
    PageHeader {
        id: header
        text: qsTr("Settings")
    }

    Flickable {
        width: parent.width; height: parent.height
        contentWidth: parent.width; contentHeight: parent.height
        flickableDirection: Flickable.VerticalFlick
        anchors.top: header.bottom

    ContactsWidget {

        id: contactsWidget
//        anchors.top: header.bottom
    }

    VideoWidget {
        id: videoWidget
        anchors.top: contactsWidget.bottom
    }

    LocationWidget {
        id: locationWidget
        anchors.top: videoWidget.bottom
    }
}
}
