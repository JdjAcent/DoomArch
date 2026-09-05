import dbus


UPOWER_SERVICE = "org.freedesktop.UPower"
UPOWER_PATH = "/org/freedesktop/UPower"
UPOWER_INTERFACE = "org.freedesktop.UPower"
DEVICE_INTERFACE = "org.freedesktop.UPower.Device"

DISPLAY_DEVICE = "/org/freedesktop/UPower/devices/DisplayDevice"

UPOWER_STATE = {
    0: "unknown",
    1: "charging",
    2: "discharging",
    3: "empty",
    4: "fully-charged",
    5: "pending-charge",
    6: "pending-discharge",
}


def get_property(bus, path, name):
    obj = bus.get_object(UPOWER_SERVICE, path)
    properties = dbus.Interface(
        obj,
        "org.freedesktop.DBus.Properties",
    )

    return properties.Get(DEVICE_INTERFACE, name)


def find_line_power(bus):
    obj = bus.get_object(UPOWER_SERVICE, UPOWER_PATH)
    upower = dbus.Interface(obj, UPOWER_INTERFACE)

    for path in upower.EnumerateDevices():
        device_type = get_property(bus, path, "Type")

        if int(device_type) != 1:
            continue

        if bool(get_property(bus, path, "Online")):
            return True

    return False


def get_battery():
    bus = dbus.SystemBus()

    percentage = get_property(bus, DISPLAY_DEVICE, "Percentage")
    state = get_property(bus, DISPLAY_DEVICE, "State")

    return {
        "percentage": float(percentage) / 100,
        "state": UPOWER_STATE.get(int(state), "unknown"),
        "external_power": find_line_power(bus),
    }
