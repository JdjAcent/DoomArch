import QtQuick
import Quickshell.Services.Pipewire
import "../theme"

Column {
    id: root

    spacing: 8

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Text {
        text: "AUDIO"
        color: Theme.textMuted
        font.pixelSize: 12
    }

    Text {
        text: Pipewire.defaultAudioSink?.audio
            ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%"
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
            width: parent.width
                * (Pipewire.defaultAudioSink?.audio?.volume ?? 0)

            height: parent.height
            radius: parent.radius
            color: Theme.textPrimary

            Behavior on width {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }
    	}
	
	MouseArea {
    		anchors.fill: parent

    		onPressed: mouse => {
        		if (Pipewire.defaultAudioSink?.audio)
            		Pipewire.defaultAudioSink.audio.volume = mouse.x / width
    		}

    		onPositionChanged: mouse => {
        		if (pressed && Pipewire.defaultAudioSink?.audio)
            		Pipewire.defaultAudioSink.audio.volume =
                		Math.max(0, Math.min(1, mouse.x / width))
    		}
	}	
    }
}
