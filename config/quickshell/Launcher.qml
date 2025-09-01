import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
PopupWindow {
    anchor.window: bar
    anchor.rect.x: 0
    anchor.rect.y: parentWindow.height
    width: 250
    height: 300
    visible: false
    Rectangle {
        TextField {
            id: search
            width: 250; height: 24
            focus: true
        } 
        ScrollView {
            height: 276
            anchors.bottom: parent.bottom
            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    model: DesktopEntries.applications.values
                    Rectangle {
                        width: 250; height: 20
                        required property DesktopEntry modelData
                        Text {
                            text: modelData.name
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: modelData.execute()
                        }
                    }
                }
            }
        }
    }
}
