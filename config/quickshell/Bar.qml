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
      Keys.onPressed: event => {
      	if (event.key == Qt.Key_Escape) appLauncher.visible = false;
      	if (event.key == Qt.Key_F1) appLauncher.visible = !appLauncher.visible;
      }
      color: "#FF0F0F0F"

      Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: "#FF171010"
        gradient: Gradient {
          GradientStop { position: 0.0; color: "#FF181818"}
          GradientStop { position: 1.0; color: "#FF1F1F1F"}
        }
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
          color: "gainsboro"
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
