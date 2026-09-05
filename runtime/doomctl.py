import json
import sys

from doom.agent import run
from doom.dispatcher import invoke
from doom.capabilities import CAPABILITIES
from doom.audio import get_audio, set_muted, set_volume
from doom.battery import get_battery


def main():
    args = sys.argv[1:]
    
    if len(args) >= 2 and args[0] == "agent":
        user_request = " ".join(args[1:])
        result = run(user_request)

    elif args == ["invoke"]:
        result = invoke_json()

    elif args == ["capabilities"]:
        result = CAPABILITIES

    elif args == ["system", "battery"]:
        result = invoke("system.battery")

    elif args == ["audio", "get"]:
        result = invoke("audio.get")

    elif len(args) == 3 and args[:2] == ["audio", "set-volume"]:
        result = invoke("audio.set-volume",{"volume":float(args[2])},)

    elif args == ["audio", "mute"]:
        result = invoke("audio.mute")

    elif args == ["audio", "unmute"]:
        result = invoke("audio.unmute")

    else:
        print(
            "usage: doomctl system battery | "
            "audio get | audio set-volume <0..1> | "
            "audio mute | audio unmute",
            file=sys.stderr,
        )
        raise SystemExit(2)

    print(json.dumps(result, indent=2))

def invoke_json():
    request = json.load(sys.stdin)

    capability = request["capability"]
    arguments = request.get("arguments", {})

    return invoke(capability, arguments)

if __name__ == "__main__":
    main()
