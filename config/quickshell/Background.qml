import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: background
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    WlrLayershell.layer: WlrLayer.Background

    Image {
        anchors.fill: parent
        fillMode: Image.Pad
        source: "/home/dylan/.local/share/wallpaper.jpg"
    }

            
    Process {
        id: ls
        running: true
        property list<string> desktopNames: []
        command: ["ls", "/home/dylan/Desktop"]
        stdout: StdioCollector {
            onStreamFinished: {
                var items = this.text.split(/\r\n|\r|\n/);
                ls.desktopNames.length = 0;
                for (var i=0;i<items.length -1;i++) {
                    ls.desktopNames.push(items[i]);
                }               
                
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: ls.running = true
    }
    Grid {
        anchors.fill: parent
        columns: background.width/128
        rows: background.height/128
        flow: Grid.TopToBottom
        Repeater {
            model: ls.desktopNames
            MouseArea {
                width: 128
                height: 128
                onClicked: xdgopen.running = true
                Process {
                    id: xdgopen
                    command: ["xdg-open", "/home/dylan/Desktop/" + modelData]   
                }
                
                Rectangle {
                    visible: mouse.hovered 
                    anchors.fill: parent
                    color: "#110000FF"
                    border {
                        color: "#220000FF"
                        width: 1
                    }
                }
                Image {
                    source: Quickshell.iconPath("unknown")
                    height: 64
                    width: 64
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.margins: 16

                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.margins: 16
                    text: modelData
                }

                

                HoverHandler {
                    id: mouse
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                }
            }
        }
    }
}
