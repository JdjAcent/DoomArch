import QtQuick
import Quickshell
import "../theme"

Column {
    id: root

    spacing: 10

    property bool expanded: false
    property string pendingAction: ""

    Text {
        text: root.expanded ? "SESSION  ⌄" : "SESSION  ›"
        color: Theme.textMuted
        font.pixelSize: Theme.textSizeLabel

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
            color: Theme.textSecondary

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["hyprlock"])
            }
        }

        Text {
            text: "Suspend"
            color: Theme.textSecondary

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["systemctl", "suspend"])
            }
        }

        Text {
            text: "Logout"
            color: Theme.textSecondary

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(["uwsm", "stop"])
            }
        }

        Text {
            text: "Reboot"
            color: Theme.textSecondary

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.pendingAction = "reboot"
            }
        }

        Text {
            text: "Power off"
            color: Theme.textSecondary

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

            color: Theme.textPrimary
            font.pixelSize: 16
        }

        Row {
            spacing: 18

            Text {
                text: "Cancel"
                color: Theme.textMuted
                font.pixelSize: Theme.textSizeBody

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.pendingAction = ""
                }
            }

            Text {
                text: "Confirm"
                color: Theme.textPrimary
                font.pixelSize: Theme.textSizeBody

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
