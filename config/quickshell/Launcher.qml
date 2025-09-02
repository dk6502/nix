import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
PanelWindow {
    width: 250
    height: 300
    visible: false
    id: launcher
    anchors {
        top: true
        left: true
    }
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    Rectangle {
        TextField{
            id: searchField
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
            ListView {
                clip: true
                model: ScriptModel {
                    values: DesktopEntries.applications.values.map(x => x).filter(entry => {
                        const search = searchField.text.toLowerCase();
                        const name = entry.name.toLowerCase();
                        return search.length ? name.indexOf(search) > -1 : true;
                    })
                }
                delegate: MouseArea {
                    width: 250
                    height: 24
                    Text {
                        text: modelData.name
                    }
                    onClicked: {
                        modelData.execute();
                        launcher.visible = false;
                        searchField.clear();
                    }
                }
            }
        }
    }
}
