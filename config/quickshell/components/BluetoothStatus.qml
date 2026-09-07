import QtQuick
import Quickshell.Bluetooth
import "../theme"

Column {
    id: root

    spacing: 8

    property bool expanded: false
    property var adapter: Bluetooth.defaultAdapter

    property var connectedDevice: {
        for (let i = 0; i < Bluetooth.devices.values.length; i++) {
            const device = Bluetooth.devices.values[i]

            if (device.connected)
                return device
        }

        return null
    }

    Text {
        text: "BLUETOOTH"
        color: Theme.textMuted
        font.pixelSize: 12

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: root.expanded = !root.expanded
        }
    }

    Row {
        spacing: 10

        Rectangle {
            width: 8
            height: 8
            radius: 4
            anchors.verticalCenter: parent.verticalCenter

            color: root.connectedDevice
                ? Theme.textPrimary
                : "#44ffffff"
        }

        Text {
            text: {
                if (!root.adapter)
                    return "Unavailable"

                if (!root.adapter.enabled)
                    return "Off"

                if (root.connectedDevice)
                    return root.connectedDevice.name

                return "On"
            }

            color: Theme.textPrimary
            font.pixelSize: 18
        }
    }

    Text {
        visible: root.adapter !== null
            && root.adapter.enabled
            && root.connectedDevice === null
            && !root.expanded

        text: "No devices connected"
        color: "#66ffffff"
        font.pixelSize: 12
    }

    Column {
        visible: root.expanded
            && root.adapter !== null
            && root.adapter.enabled

        spacing: 8

        Repeater {
            model: Bluetooth.devices

            delegate: Row {
                id: deviceRow

                required property var modelData

                spacing: 10

                Rectangle {
                    width: 6
                    height: 6
                    radius: 3
                    anchors.verticalCenter: parent.verticalCenter

                    color: deviceRow.modelData.connected
                        ? Theme.textPrimary
                        : Theme.track
                }

                Text {
                    text: deviceRow.modelData.name
                    color: Theme.textSecondary
                    font.pixelSize: 13
                }

                Text {
                    text: deviceRow.modelData.connected
                        ? "Disconnect"
                        : "Connect"

                    color: "#77ffffff"
                    font.pixelSize: 12

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if (deviceRow.modelData.connected)
                                deviceRow.modelData.disconnect()
                            else
                                deviceRow.modelData.connect()
                        }
                    }
                }
            }
        }
    }
}
