import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Row {
    Repeater {
        model: 5

        Rectangle {
            color: "yellow"
            border.width: 1
            width: 40; height: 20
        }
    }
}
