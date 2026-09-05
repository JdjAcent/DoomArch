import subprocess


DEFAULT_SINK = "@DEFAULT_AUDIO_SINK@"


def get_audio():
    result = subprocess.run(
        ["wpctl", "get-volume", DEFAULT_SINK],
        capture_output=True,
        text=True,
        check=True,
    )

    parts = result.stdout.split()

    return {
        "volume": float(parts[1]),
        "muted": "[MUTED]" in result.stdout,
    }


def set_volume(volume):
    volume = max(0.0, min(1.0, volume))

    subprocess.run(
        ["wpctl", "set-volume", DEFAULT_SINK, str(volume)],
        check=True,
    )

    return get_audio()


def set_muted(muted):
    subprocess.run(
        ["wpctl", "set-mute", DEFAULT_SINK, "1" if muted else "0"],
        check=True,
    )

    return get_audio()
