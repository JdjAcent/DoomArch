import QtQuick
import Quickshell
import Quickshell.Networking

Column {
    id: root

    spacing: 8

    property bool expanded: false

    property var wifiDevice: {
        for (let i = 0; i < Networking.devices.values.length; i++) {
            const device = Networking.devices.values[i]

            if (device.type === DeviceType.Wifi)
                return device
        }

        return null
    }

    property var activeNetwork: {
        if (!wifiDevice)
            return null

        for (let i = 0; i < wifiDevice.networks.values.length; i++) {
            const network = wifiDevice.networks.values[i]

            if (network.connected)
                return network
        }

        return null
    }

    Text {
        text: "NETWORK"
        color: Theme.textMuted
        font.pixelSize: 12

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: root.expanded = !root.expanded
        }
    }

    Text {
        text: root.activeNetwork
            ? root.activeNetwork.name
            : "Disconnected"

        color: Theme.textPrimary
        font.pixelSize: 18
    }

    Row {
        spacing: 6

        Repeater {
            model: 4

            Rectangle {
                id: segment

                required property int index

                width: 54
                height: 6
                radius: 3
                color: Theme.track

                property real fill: root.activeNetwork
                    ? Math.max(
                        0,
                        Math.min(
                            1,
                            root.activeNetwork.signalStrength * 4 - index
                        )
                    )
                    : 0

                Rectangle {
                    width: parent.width * segment.fill
                    height: parent.height
                    radius: parent.radius
                    color: Theme.textPrimary

                    Behavior on width {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }
    }

    Text {
        visible: root.expanded

        text: "Manage network"
        color: "#bbffffff"
        font.pixelSize: 13

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: Quickshell.execDetached([
                "kitty",
                "nmtui"
            ])
        }
    }
}
