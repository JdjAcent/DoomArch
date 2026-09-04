import Quickshell
import Quickshell.Io

import "surfaces"

ShellRoot {
    id: root

    property bool controlPanelVisible: false

    IpcHandler {
        target: "doom"

        function toggle(): void {
            root.controlPanelVisible = !root.controlPanelVisible
        }
    }

    ControlPanel {
        panelVisible: root.controlPanelVisible
    }
}
