import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris

PanelWindow {
    implicitHeight: 400
    implicitWidth: 400
    anchors.top: true
    anchors.right: true
    visible: false
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.bottom
    Rectangle {
        anchors.fill: parent
        color: "#FFF1F1F1"
        border.width: 1
        border.color: "#FF3c454d"

        Repeater {
            anchors.top: parent.top
            anchors.topMargin: 40
            model: Mpris.players.values
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 1.0; color: "#FF242a2e"}
                    GradientStop { position: 0.0; color: "#FF30383d"}
                }
                anchors.topMargin: 5
                border.color: "#FF3c454d"
                height: 60
                width: parent.width - 10
                Image {
                    id: albumArt
                    source: modelData.trackArtUrl
                    height: parent.height - 2
                    width: parent.height - 2
                    anchors.left: parent.left
                    anchors.leftMargin: 1
                    anchors.verticalCenter: parent.verticalCenter
                    
                }
                Text {
                    anchors.left: albumArt.right
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.trackTitle + "\n" + modelData.trackArtist
                    color: "slategrey"
                }
                MouseArea {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    width: 60
                    height: 60
                    onClicked: modelData.togglePlaying()
                    Image {
                        anchors.fill: parent
                        anchors.margins: 6
                        width: 48
                        height: 48
                        source: modelData.isPlaying ? Quickshell.iconPath("media-playback-pause") : Quickshell.iconPath("media-playback-start")
                    }
                    
                }
            }
        }
    }
}
