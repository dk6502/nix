import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
PanelWindow {
    width: 250
    height: 400
    visible: false
    id: launcher
    anchors {
        top: true
        left: true
    }
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    Rectangle {
        id: osBox
        anchors.left: parent.left
        width: 40; height: parent.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF245278"}
            GradientStop { position: 1.0; color: "#FF25548A"}
        }
        Text {
            FileView {
                id: os_release
                path: Qt.resolvedUrl("/etc/os-release")
                readonly property var prettyName: os_release.text().split("=")[14].split(/\r?\n/)[0].replace(new RegExp("\"", "g"),"");
            }
            id: osText
            transform: Rotation {
                origin.x: 12
                origin.y: 0
                angle: -90
            }
            anchors.top: parent.top
            anchors.topMargin: 375
            font.bold: true
            font.pointSize: 24
            text: os_release.prettyName
            color: "white"
        }
    }
    Rectangle {
        anchors.left: osBox.right
        anchors.right: parent.right
        height: parent.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#FF181818"}
            GradientStop { position: 1.0; color: "#FF1F1F1F"}
        }
        ScrollView {
            width: parent.width; height: parent.height - searchBox.height
            anchors.top: parent.top
            id: apps
            anchors.bottom: searchBox.top
            ListView {
                clip: true
                highlightFollowsCurrentItem: true
                keyNavigationEnabled: true
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
                        text: " " + modelData.name
                        color: "gainsboro"
                    }
                    onClicked: {
                        modelData.execute();
                        launcher.visible = false;
                        searchField.clear();
                    }
                }
            }
        }
        Rectangle {
            id: searchBox
            height: 72
            width: parent.width
            color: "#00000000"
            anchors.top: apps.bottom
            anchors.bottom: parent.bottom
            ColumnLayout {
                width: parent.width
                MouseArea {
                    width: parent.width
                    height: 36
                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        padding: 8
                        spacing: 6
                        Image {
                            source: Quickshell.iconPath("system-shutdown")
                            height: 24; width: 24
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Exit"
                            color: "gainsboro"
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: ">"
                            color: "grey"
                        }
                    }
                }
                TextField {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    height: 24
                    id: searchField
                    focus: true
                    width: parent.width - 10
                    Image {
                        source: Quickshell.iconPath("system-search")
                        height: 24; width: 24
                        anchors.right: parent.right
                    }
                    background: Rectangle {
                        radius: 0
                        implicitWidth: parent.width
                    }
                }
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "#FF101010"
    }
}
