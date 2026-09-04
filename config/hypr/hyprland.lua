-- DoomArch Hyprland configuration.
--
-- Keep this file small. Subsystems live in doomarch/*.lua.

-- Outputs
require("doomarch/monitors")

-- Input and interaction
require("doomarch/input")
require("doomarch/bindings")
require("doomarch/media")

-- Window behavior and appearance
require("doomarch/layout")
require("doomarch/appearance")

-- Environment
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Hyprland defaults that DoomArch intentionally disables.
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})
