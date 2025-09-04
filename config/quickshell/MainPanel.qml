import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris

PanelWindow {
    implicitHeight: 400
    implicitWidth: 400
    anchors.top: true
    visible: false
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.bottom
    Rectangle {
        anchors.fill: parent
        color: "#FFF1F1F1"
        Repeater {
            model: Mpris.players.values
            Rectangle {
                color: "white"
                height: 24
                width: parent.width - 20
                Text {
                    anchors.fill: parent
                    text: modelData.trackArtist
                }
            }
        }
    }
}
