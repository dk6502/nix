import QtQuick
import Quickshell
import Quickshell.Services.Mpris
Repeater {
   id: mpris
   anchors.top: parent.top
   model: Mpris.players.values
   Rectangle {
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.top: parent.top
       anchors.topMargin: 5
       border.color: colors.barBorderColor
       height: 60
       width: parent.width - 10
       gradient: panelGradient
       Image {
           id: albumArt
           source: modelData.trackArtUrl
           height: parent.height - 2
           width: parent.height - 2
           anchors.left: parent.left
           anchors.leftMargin: 1
           anchors.verticalCenter: parent.verticalCenter
           
       }
       Text {
           anchors.left: albumArt.right
           anchors.leftMargin: 6
           anchors.verticalCenter: parent.verticalCenter
           text: modelData.trackTitle +"\n" + modelData.trackArtist
           color: colors.panelTextColor
       }
       MouseArea {
           anchors.right: parent.right
           anchors.bottom: parent.bottom
           anchors.top: parent.top
           width: 60
           height: 60
           onClicked: modelData.togglePlaying()
           Image {
               anchors.fill: parent
               anchors.margins: 14
               width: 32
               height: 32
               source: modelData.isPlaying ? Quickshell.iconPath("media-playback-pause") : Quickshell.iconPath("media-playback-start")
           }       
       }
   }
}
