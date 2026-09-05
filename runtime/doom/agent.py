import json
import urllib.request

from doom.capabilities import CAPABILITIES
from doom.dispatcher import invoke


MODEL_URL = "http://127.0.0.1:8080/v1/chat/completions"


def build_prompt(user_request):
    capabilities = json.dumps(CAPABILITIES, indent=2)

    return f"""
You are Doom, a local system agent working for the owner of this computer.

Translate the owner's request into exactly one available Doom capability.

Available capabilities:

{capabilities}

Return ONLY valid JSON:

{{
  "capability": "exact.capability.name",
  "arguments": {{}}
}}

The capability name MUST exactly match one of the available capabilities.
Do not invent or rename capabilities.
Respect argument types and ranges exactly.

Owner request:
{user_request}
""".strip()


def plan(user_request):
    tools = []

    for name, spec in CAPABILITIES.items():
        properties = {}
        required = []

        for argument, argument_spec in spec.get("arguments", {}).items():
            properties[argument] = {
                key: value
                for key, value in argument_spec.items()
                if key in {
                    "type",
                    "description",
                    "minimum",
                    "maximum",
                }
            }
            required.append(argument)

        tools.append({
            "type": "function",
            "function": {
                "name": name,
                "description": spec["description"],
                "parameters": {
                    "type": "object",
                    "properties": properties,
                    "required": required,
                    "additionalProperties": False,
                },
            },
        })

    payload = {
        "model": "local",
        "messages": [
            {
                "role": "system",
                "content": (
                    "You are Doom, the local system agent. "
                    "Use exactly one provided tool to perform "
                    "the owner's request."
                ),
            },
            {
                "role": "user",
                "content": user_request,
            },
        ],
        "tools": tools,
        "tool_choice": "required",
        "temperature": 0,
    }

    request = urllib.request.Request(
        MODEL_URL,
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"},
    )

    with urllib.request.urlopen(request) as response:
        result = json.load(response)

    message = result["choices"][0]["message"]
    tool_call = message["tool_calls"][0]["function"]

    arguments = tool_call["arguments"]

    if isinstance(arguments, str):
        arguments = json.loads(arguments)

    return {
        "capability": tool_call["name"],
        "arguments": arguments,
    }

def run(user_request):
    request = plan(user_request)

    print("Doom plan:")
    print(json.dumps(request, indent=2))

    return invoke(
        request["capability"],
        request.get("arguments", {}),
    )
