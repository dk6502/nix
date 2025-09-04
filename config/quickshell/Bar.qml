import Quickshell
import Quickshell.Wayland
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls
import QtQuick.Effects

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

      Colors {
        id: colors
      }
      Keys.onPressed: event => {
      	if (event.key == Qt.Key_Escape) appLauncher.visible = false;
      	if (event.key == Qt.Key_F1) appLauncher.visible = !appLauncher.visible;
      }
      color: "#FF0F0F0F"

      Rectangle {
        anchors.fill: parent
        border.width: 1
        border.color: colors.barBorderColor
        gradient: Gradient {
          GradientStop { position: 0.0; color: colors.barColor }
          GradientStop { position: 1.0; color: colors.barColorTo}
        }
      }

      Launcher {
        id: appLauncher
      }

      MainPanel {
        id: mainPanel
      }
                  
      Row {
        anchors.left: parent.left
        MouseArea {
          id: launchButton
          width: bar.height+2; height: bar.height
          onClicked: appLauncher.visible = !appLauncher.visible

          Image {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: 24; width: 28
            source: Quickshell.iconPath("kmenu")
          }
        }
      }


      Rectangle {
        anchors.right: parent.right
        height: 24
        width: 100
        color: mainPanel.visible ? "#33000000" : "transparent"
        antialiasing: false
        border.width: mouse.hovered ? 1 : 0
        border.color: "darkslategray"
        radius: 8

        HoverHandler {
          id: mouse
          acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
          cursorShape: Qt.PointingHandCursor
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {
            mainPanel.visible = !mainPanel.visible
            // parent.color = "#55000000"
          }
          Row {
            anchors.centerIn: parent
            id: middle
            ClockWidget {
              color: colors.barTextColor
              font.pointSize: 30
            }
            Text {
              text: " - " + UPower.displayDevice.timeToFull
              color: colors.barTextColor
              font.pointSize: 30
            }
          }
        }
      }

      Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
      }
    }
  }
}
