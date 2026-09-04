import QtQuick
import Quickshell.Services.UPower

Column {
    spacing: 8

    Text {
        text: "POWER"
        color: "#88ffffff"
        font.pixelSize: 12
    }

    Text {
        text: UPower.displayDevice.ready
            ? Math.round(UPower.displayDevice.percentage * 100) + "%"
            : "..."

        color: "white"
        font.pixelSize: 18
    }

    Rectangle {
        width: 240
        height: 6
        radius: 3
        color: "#33ffffff"

        Rectangle {
            width: parent.width * UPower.displayDevice.percentage
            height: parent.height
            radius: parent.radius
            color: "white"

            Behavior on width {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
