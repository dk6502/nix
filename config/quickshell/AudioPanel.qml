import QtQuick
import Quickshell
import QtQuick.Controls
import Quickshell.Services.Pipewire

Rectangle {
    visible: Pipewire.ready
    anchors.horizontalCenter: parent.horizontalCenter 
    width: parent.width - 10
    height: 60
    color: "#FFF1F1F1"
    border.color: colors.barBorderColor
    gradient: panelGradient
    Column {
        anchors.fill: parent
        Item {
            width: parent.width
            height: parent.height/2
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 10
                id: volumeImage
                source: Quickshell.iconPath("sound1")
                anchors.verticalCenter: parent.verticalCenter
                width: 16
                height: 16
            }
            Button {
                anchors.left: volumeImage.right
                anchors.leftMargin: 5 
                id: volumeName
                background: ButtonBackground {
                    anchors.fill: parent
                } 
                text: Pipewire.defaultAudioSink.nickname
                anchors.verticalCenter: parent.verticalCenter
                onClicked: menu.open()
                Menu {
                    id: menu
                    y: volumeName.height

                    Repeater {
                        model: Pipewire.nodes.values.filter( a => a.isSink).filter (a => (a.isStream == false))

                        MenuItem {
                            text: modelData.nickname
                            onClicked: {
                                Pipewire.preferredDefaultAudioSink = modelData;
                                outputVolume.moved();
                                
                            }
                        }
                    }
                }
            }
            Slider {
                anchors.verticalCenter: parent.verticalCenter
                id: outputVolume
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: volumeName.right
                anchors.leftMargin: 10
                snapMode: Slider.SnapAlways
                stepSize: 0.1
                value: 0.5
                onMoved: Pipewire.defaultAudioSink.audio.volume = outputVolume.position;
            }
        }
        Item {
            width: parent.width
            height: parent.height/2
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 10
                id: micImage
                source: Quickshell.iconPath("mix_microphone")
                anchors.verticalCenter: parent.verticalCenter
                width: 16
                height: 16
            }
            Button {
                anchors.left: micImage.right
                anchors.leftMargin: 5 
                id: inputName
                background: ButtonBackground {
                    anchors.fill: parent
                } 
                text: Pipewire.defaultAudioSource.nickname
                anchors.verticalCenter: parent.verticalCenter
                onClicked: inputMenu.open()
                Menu {
                    id: inputMenu
                    y: inputName.height

                    Repeater {
                        model: Pipewire.nodes.values.filter(a => (a.isStream == false && a.isSink == false && a.audio))

                        MenuItem {
                            text: modelData.nickname
                            onClicked: {
                                Pipewire.preferredDefaultAudioSource = modelData;
                                inputVolume.moved();
                                
                            }
                        }
                    }
                }
            }
            Slider {
                anchors.verticalCenter: parent.verticalCenter
                id: inputVolume
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: inputName.right
                anchors.leftMargin: 10
                snapMode: Slider.SnapAlways
                stepSize: 0.1
                value: 0.5
                onMoved: Pipewire.defaultAudioSource.audio.volume = inputVolume.position
                
            }
        }
    }
}
