// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtMultimediaKit 1.1
import com.nokia.meego 1.0

Page {

    Camera {
            id:camera
            x:0; y: 0
            width:parent.width; height:parent.height
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
                anchors.right:parent.right
                anchors.top: parent.top
                width: 200
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
