import QtQuick
import Quickshell.Services.UPower
import "../theme"

Column {
    spacing: 8

    Text {
        text: "POWER"
        color: Theme.textMuted
        font.pixelSize: 12
    }

    Text {
        text: UPower.displayDevice.ready
            ? Math.round(UPower.displayDevice.percentage * 100) + "%"
            : "..."

        color: Theme.textPrimary
        font.pixelSize: 18
    }

    Rectangle {
        width: 240
        height: 6
        radius: 3
        color: Theme.track

        Rectangle {
            width: parent.width * UPower.displayDevice.percentage
            height: parent.height
            radius: parent.radius
            color: Theme.textPrimary

            Behavior on width {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
