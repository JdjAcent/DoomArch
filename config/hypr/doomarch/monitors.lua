-- DoomArch monitor configuration.

-- Prefer the maximum refresh rate of the reference external monitor.
hl.monitor({
    output   = "desc:Lenovo Group Limited L24i-4A UMHPN6YA",
    mode     = "1920x1080@99.93",
    position = "auto",
    scale    = 1,
})

-- Portable fallback for all other outputs.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
