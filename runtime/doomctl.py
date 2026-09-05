import json
import sys

from doom.audio import get_audio, set_muted, set_volume
from doom.battery import get_battery


def main():
    args = sys.argv[1:]

    if args == ["system", "battery"]:
        result = get_battery()

    elif args == ["audio", "get"]:
        result = get_audio()

    elif len(args) == 3 and args[:2] == ["audio", "set-volume"]:
        result = set_volume(float(args[2]))

    elif args == ["audio", "mute"]:
        result = set_muted(True)

    elif args == ["audio", "unmute"]:
        result = set_muted(False)

    else:
        print(
            "usage: doomctl system battery | "
            "audio get | audio set-volume <0..1> | "
            "audio mute | audio unmute",
            file=sys.stderr,
        )
        raise SystemExit(2)

    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
