import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: app
    showToolBar: true;

    initialPage: MainPage{}

    ToolBar {
        anchors.bottom: parent.bottom
    }

    CameraPage {
        id: cameraPage
    }

    SettingsPage {
        id: settingsPage
    }

    MessageBox {
        id: messageBox
    }
}
