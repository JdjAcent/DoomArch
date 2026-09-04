-- DoomArch base appearance.
-- Intentionally neutral while the visual identity is still evolving.

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,

        border_size = 2,
        resize_on_border = true,
        allow_tearing = false,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
        },
    },

    animations = {
        enabled = true,
    },
})
