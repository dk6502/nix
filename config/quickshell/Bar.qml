import Quickshell
import Quickshell.Wayland
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "mainPanel" as Panel

Scope {
  // no more time object

  Variants {
    model: Quickshell.screens
    
    PanelWindow {
      required property var modelData
      screen: modelData
      id: bar
      implicitHeight: 44
      anchors {
        bottom: true
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

      Panel.MainPanel {
        id: mainPanel
      }
                  
      Row {
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 8
        MouseArea {
          anchors.verticalCenter: parent.verticalCenter
          id: launchButton
          width: startText.width + 20; height: bar.height
          onClicked: appLauncher.visible = !appLauncher.visible
          Rectangle {
            anchors.fill: parent
            color: appLauncher.visible ? "#33000000" : "transparent"
            antialiasing: false
            border.width: mouseLauncher.hovered ? 1 : 0
            border.color: colors.barBorderColor
            radius: 8
            Text {
              anchors.centerIn: parent
              id: startText
              text: "Start"
              color: colors.barTextColor
            }

            HoverHandler {
              id: mouseLauncher
              acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
              cursorShape: Qt.PointingHandCursor
            }
          }
        }
        Row {
          spacing: 8
          Repeater {
            model: ToplevelManager.toplevels
            Button {
              width: bar.height
              height: bar.height
              onClicked: modelData.activate()
              background: Rectangle {
                radius: 8
                antialiasing: false
                border.width: 1
                border.color: colors.barBorderColor
                color: "transparent"
                Image {
                  anchors.fill: parent
                  anchors.margins: 6
                  source: Quickshell.iconPath(modelData.appId)
                }
              }
            }
          }
        }
      }


      Rectangle {
        anchors.right: parent.right
        height: bar.height
        width: 150
        color: mainPanel.visible ? "#33000000" : "transparent"
        antialiasing: false
        border.width: mouse.hovered ? 1 : 0
        border.color: colors.barBorderColor
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
              text: " - " + (UPower.displayDevice.percentage * 100).toFixed(2) + "%"
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
