// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMultimediaKit 1.1
import com.nokia.meego 1.0

Page {
    anchors.fill: parent; rotation: screen.currentOrientation == 1 ? 90:0
    Camera {
            id:camera
            x:0; y: 0
            anchors.centerIn: parent
            focus : visible // to receive focus and capture key events when visible
            opacity: 1

            flashMode: Camera.FlashRedEyeReduction
            whiteBalanceMode: Camera.WhiteBalanceFlash
            exposureCompensation: -1.0

            onImageCaptured : {
                console.debug("Captured Image:" +preview);
                preview.opacity=1;
                camera.opacity=0;
                preview.source = preview;
            }
            onImageSaved: {
                console.log("Image saved:"+path);
                preview.opacity=1;
                camera.opacity=0;
            }

            Button{
                id:settingsButton
                rotation: screen.currentOrientation == 1 ? 270:0
                anchors.verticalCenter: rotation == 270 ? parent.verticalCenter:undefined
                anchors.horizontalCenter: rotation == 0? parent.horizontalCenter:undefined
                text:"Settings"

                onClicked: {
                    camera.captureImage();
                }
            }
        }

    tools: ToolBarLayout {
        Button {
            id:cancelButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Cancel"
        }
    }
}
