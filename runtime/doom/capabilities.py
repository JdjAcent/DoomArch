CAPABILITIES = {
    "system.battery": {
        "access": "read",
        "description": "Read battery and external power state.",
    },

    "audio.get": {
        "access": "read",
        "description": "Read default audio output state.",
    },

    "audio.set-volume": {
        "access": "write",
        "description": (
            "Set default audio output volume using a normalized level."
        ),
        "arguments": {
            "volume": {
                "type": "number",
                "minimum": 0.0,
                "maximum": 1.0,
                "description": (
                    "Normalized volume from 0.0 to 1.0. "
                    "Convert percentages by dividing by 100: "
                    "35% = 0.35, 60% = 0.60, 100% = 1.0."
                ),
            },
        },
    },

    "audio.mute": {
        "access": "write",
        "description": "Mute default audio output.",
    },

    "audio.unmute": {
        "access": "write",
        "description": "Unmute default audio output.",
    },
}
