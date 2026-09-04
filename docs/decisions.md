# DoomArch Decisions

## Repository philosophy

DoomArch is built incrementally. The repository tracks intentional
configuration and architectural decisions instead of mirroring `$HOME`.

## Portability

Portable configuration should not unnecessarily depend on the current
laptop, device names, paths, or other machine-specific details.

## KDE Plasma

KDE Plasma remains installed and functional as a stable fallback while the
Hyprland environment is developed.

## Documentation language

Public project documentation is written in English.

## Monitor configuration

Monitor behavior starts from a portable automatic fallback using preferred mode,
automatic positioning, and automatic scaling.

The reference Lenovo L24i-4A external monitor has a specific override to use its
1920x1080 mode at approximately 100 Hz. It is matched by monitor description
instead of connector name so the configuration does not depend on `HDMI-A-1`.

Monitor configuration is isolated in `doomarch/monitors.lua` so hardware-specific
overrides can remain separate from the main Hyprland configuration.

## Core keybindings and media controls

`SUPER` is the main DoomArch modifier.

The initial application bindings use Kitty as the terminal, Dolphin as the file
manager, and Hyprlauncher as the launcher. These choices can be revisited as
DoomArch evolves.

Core window and workspace bindings are kept separate from hardware and media
controls.

Media controls use the existing PipeWire stack through `wpctl`. Brightness
controls use `brightnessctl`, and media playback controls use `playerctl`.
