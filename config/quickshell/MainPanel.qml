import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
    implicitWidth: 400
    anchors.top: true
    anchors.right: true
    anchors.bottom: true
    visible: false
    exclusionMode: ExclusionMode.Normal
    WlrLayershell.layer: WlrLayer.bottom
    PwObjectTracker { objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource] }

    PanelGradient {
        id: panelGradient
    }
    
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 1.0; color: colors.barColor}
            GradientStop { position: 0.0; color: colors.barColorTo}
        }
        border.width: 1
        border.color: "#FF3c454d"

        MusicPlayer {
            id: mpris
        }

        AudioPanel {
            y: Mpris.players.values.length * 35
        }
    }
}
