from doom.audio import get_audio, set_muted, set_volume
from doom.battery import get_battery
from doom.validation import validate


def invoke(name, arguments=None):
    arguments = arguments or {}
    
    validate(name, arguments)

    if name == "system.battery":
        return get_battery()

    if name == "audio.get":
        return get_audio()

    if name == "audio.set-volume":
        return set_volume(arguments["volume"])

    if name == "audio.mute":
        return set_muted(True)

    if name == "audio.unmute":
        return set_muted(False)

    raise ValueError(f"unknown capability: {name}")
