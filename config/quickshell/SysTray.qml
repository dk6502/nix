import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Repeater {
    model: SystemTray.items
    Image {
        source: modelData.icon
        height: 22; width: 22
    }
}
