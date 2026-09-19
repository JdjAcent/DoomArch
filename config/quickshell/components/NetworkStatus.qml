import QtQuick
import Quickshell
import Quickshell.Networking

import "../theme"

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

    onExpandedChanged: {
        if (root.wifiDevice)
            root.wifiDevice.scannerEnabled = root.expanded
    }

    Text {
        text: "NETWORK"
        color: "#88ffffff"
        font.pixelSize: Theme.textSizeLabel

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

        color: "white"
        font.pixelSize: Theme.textSizePrimary
    }

    // Active network signal
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

    // Available networks
    Column {
        visible: root.expanded && root.wifiDevice !== null
        spacing: 8

        Repeater {
            model: root.wifiDevice
                ? root.wifiDevice.networks
                : null

            delegate: Row {
                id: networkRow

                required property var modelData

                visible: !networkRow.modelData.connected
                spacing: 10

                Text {
                    width: 170

                    text: networkRow.modelData.name
                    color: "#bbffffff"
                    font.pixelSize: Theme.textSizeBody
                    elide: Text.ElideRight
                }

                Row {
                    spacing: 3

                    Repeater {
                        model: 4

                        Rectangle {
                            id: networkSegment

                            required property int index

                            width: 10
                            height: 4
                            radius: 2
                            color: "#33ffffff"

                            property real fill: Math.max(
                                0,
                                Math.min(
                                    1,
                                    networkRow.modelData.signalStrength * 4 - index
                                )
                            )

                            Rectangle {
                                width: parent.width * networkSegment.fill
                                height: parent.height
                                radius: parent.radius
                                color: "white"

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
            }
        }
    }
}
