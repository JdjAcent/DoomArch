import QtQuick
import Quickshell

import "../theme"
import "../components"

PanelWindow {
    required property bool panelVisible

    anchors {
        top: true
        right: true
        bottom: true
    }

    implicitWidth: panelVisible ? 360 : 0
    color: "transparent"

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 220
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 16

        radius: 20
        color: Theme.surface

        Column {
            anchors {
                fill: parent
                margins: 24
            }

            spacing: 24

            Text {
                text: "DoomArch"
                color: Theme.textPrimary
                font.pixelSize: 26
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Theme.divider
            }

	    PowerStatus {}
	    AudioStatus {}
	    NetworkStatus {}
	    BluetoothStatus {}
	    SessionControls {}
        }
    }
}
