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
      implicitHeight: 24
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
                  
      Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
          width: 26; height: 24
          onClicked: appLauncher.visible = !appLauncher.visible

          Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: 22; width: 22
            source: Quickshell.iconPath("kmenu")
          }
        }
      }

      
      Row {
        anchors.centerIn: parent
        ClockWidget {
          color: "white"
        }
      }
      Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        SysTray {
          anchors.verticalCenter: verticalCenter
        }
      }
    }
  }
}
