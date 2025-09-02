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

      color: "#FF0F0F0F"

      Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: "#FF010101"
        color: "#00FFFFFF"
      }

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
        MouseArea {
          width: 26; height: 24
          onClicked: appLauncher.visible = !appLauncher.visible

          Image {
            anchors.right: parent.right
            height: 23; width: 23
            source: Quickshell.iconPath("kmenu")
          }
        }
      }
    }
  }
}
