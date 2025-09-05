import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Services.Pipewire

Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter 
    width: parent.width - 10
    height: 60
    color: "#FFF1F1F1"
    border.color: colors.barBorderColor
    gradient: panelGradient
	Column {
	    anchors.fill: parent
        Text {
            anchors.left: parent.left
            anchors.top: parent.top
            text: "Brightness: " + (brightnessSlider.value * 100).toFixed(2) + "%"
            anchors.margins: 12
        }
        Process {
            id: brightness
            command: ["brightnessctl", "set", brightnessSlider.value * 100 + "%"]
        }
        
        Slider {
            id: brightnessSlider
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.margins: 12 
            snapMode: Slider.SnapAlways
            stepSize: 0.1
            value: 0.5
            from: 0.2
            onMoved: brightness.startDetached()
        }
	}
}
