import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
PopupWindow {
    anchor.window: bar
    anchor.rect.x: 0
    anchor.rect.y: parentWindow.height
    width: 300
    height: 300
    visible: false
    ScrollView {
        anchors.fill: parent
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
