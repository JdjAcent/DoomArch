from doom.capabilities import CAPABILITIES


class CapabilityValidationError(ValueError):
    pass


def validate(name, arguments):
    if name not in CAPABILITIES:
        raise CapabilityValidationError(
            f"unknown capability: {name}"
        )

    spec = CAPABILITIES[name]
    expected = spec.get("arguments", {})

    unknown = set(arguments) - set(expected)

    if unknown:
        raise CapabilityValidationError(
            f"unknown arguments for {name}: {sorted(unknown)}"
        )

    for argument, argument_spec in expected.items():
        if argument not in arguments:
            raise CapabilityValidationError(
                f"missing argument: {argument}"
            )

        value = arguments[argument]

        if argument_spec["type"] == "number":
            if not isinstance(value, (int, float)):
                raise CapabilityValidationError(
                    f"{argument} must be a number"
                )

            minimum = argument_spec.get("minimum")
            maximum = argument_spec.get("maximum")

            if minimum is not None and value < minimum:
                raise CapabilityValidationError(
                    f"{argument} must be >= {minimum}"
                )

            if maximum is not None and value > maximum:
                raise CapabilityValidationError(
                    f"{argument} must be <= {maximum}"
                )
