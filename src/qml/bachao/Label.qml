// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Text {
    property bool small: false
    font.pixelSize: small ? 24 : 42
    color: "#752620"
}
