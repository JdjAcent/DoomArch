import QtQuick
import Quickshell

Column {
    id: root

    spacing: 10

    property bool expanded: false
    property string pendingAction: ""

    Text {
        text: root.expanded ? "SESSION  ⌄" : "SESSION  ›"
        color: "#88ffffff"
        font.pixelSize: 12

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.expanded = !root.expanded

                if (!root.expanded)
                    root.pendingAction = ""
            }
        }
    }

    Column {
        visible: root.expanded && root.pendingAction === ""
        spacing: 8

        Text {
            text: "Lock"
            color: "#ccffffff"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["hyprlock"])
            }
        }

        Text {
            text: "Suspend"
            color: "#ccffffff"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["systemctl", "suspend"])
            }
        }

        Text {
            text: "Logout"
            color: "#ccffffff"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["uwsm", "stop"])
            }
        }

        Text {
            text: "Reboot"
            color: "#ccffffff"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.pendingAction = "reboot"
            }
        }

        Text {
            text: "Power off"
            color: "#ccffffff"

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.pendingAction = "poweroff"
            }
        }
    }

    Column {
        visible: root.expanded && root.pendingAction !== ""
        spacing: 10

        Text {
            text: root.pendingAction === "reboot"
                ? "Reboot DoomArch?"
                : "Power off DoomArch?"

            color: "white"
            font.pixelSize: 16
        }

        Row {
            spacing: 18

            Text {
                text: "Cancel"
                color: "#88ffffff"
                font.pixelSize: 13

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.pendingAction = ""
                }
            }

            Text {
                text: "Confirm"
                color: "white"
                font.pixelSize: 13

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (root.pendingAction === "reboot")
                            Quickshell.execDetached([
                                "systemctl",
                                "reboot"
                            ])
                        else if (root.pendingAction === "poweroff")
                            Quickshell.execDetached([
                                "systemctl",
                                "poweroff"
                            ])
                    }
                }
            }
        }
    }
}
