import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
PanelWindow {
    width: 250
    height: 300
    visible: false
    anchors {
        top: true
        left: true
    }
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    Rectangle {
        TextField{
            id: search
            width: 250; height: 24
            focus: true
        } 
    }
    Rectangle {
        width:250; height: 276
        anchors.bottom: parent.bottom
        ScrollView {
            anchors.fill: parent.fill
            width: parent.width
            height: parent.height
            ColumnLayout {
                anchors.fill: parent.fill
                width: parent.width
                height: parent.height
                Repeater {
                    model: DesktopEntries.applications.values
                    Rectangle {
                        width: parent.width; height: 24
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
