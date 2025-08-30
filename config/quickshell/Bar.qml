import Quickshell
import QtQuick.Effects

Scope {
  // no more time object

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData
      
      anchors {
        top: true
        left: true
        right: true
      }

      color: "#99000000"
            
      implicitHeight: 24

      ClockWidget {
        anchors.centerIn: parent
        color: "white"
      }
    }
  }
}
