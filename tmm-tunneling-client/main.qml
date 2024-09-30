import QtQuick
import QtQuick.Window

Window {
    id: window
    visibility: Window.FullScreen
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: rectangle
        color: "#12c8f6"
        border.color: "#00000000"
        border.width: 0
        anchors.fill: parent
        clip: false
    }
}
