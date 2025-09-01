import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls

Scope {
  // no more time object

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      id: bar
      anchors {
        top: true
        left: true
        right: true
      }

      color: "#99000000"

      Launcher {
        id: appLauncher
      }
                  
      implicitHeight: 24
      Row {
        anchors.centerIn: parent
        ClockWidget {
          color: "white"
        }
      }
      Row {
        anchors.left: parent.left
        Rectangle {
          width: 16; height: 16
          MouseArea {
            anchors.fill: parent
            onClicked: appLauncher.visible = !appLauncher.visible
          }
        }
      }
    }
  }
}
