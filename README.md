# Corne ZMK Keymap

A Miryoku-inspired ZMK keymap for the Corne (crkbd) keyboard with nice!nano v2 controller.

## Features

- **8 layers**: Base, Navigation, Function, Media, Numbers, Symbols, System, Gaming
- **Home row mods**: GUI, Alt, Ctrl, Shift on home row (GACS pattern)
- **Miryoku-style layer access**: Hold thumb key to activate layer, content on opposite hand
- **Gaming layer**: Dedicated toggle layer without home row mods for WASD gaming
- **Bluetooth support**: 5 device profiles with easy switching

## Hardware

- **Keyboard**: Corne (crkbd) - 42 keys
- **Controller**: nice!nano v2
- **Display**: nice!view (optional)

## Layer Overview

| Layer | Name   | Access              | Description                          |
|-------|--------|---------------------|--------------------------------------|
| 0     | Base   | Default             | QWERTY with home row mods            |
| 1     | Nav    | Space (hold)        | Arrow keys, Home/End, Page Up/Down   |
| 2     | Func   | Tab (hold)          | Function keys F1-F12                 |
| 3     | Media  | Esc (hold)          | Media controls, volume               |
| 4     | Num    | Enter (hold)        | Numpad-style number entry            |
| 5     | Sym    | Backspace (hold)    | Symbols (shifted numbers)            |
| 6     | Sys    | Delete (hold)       | Bluetooth, bootloader, reset         |
| 7     | Game   | Toggle (top-right)  | Gaming mode without home row mods    |

## Keymap Visualization

> Keymap images are automatically generated using [keymap-drawer](https://github.com/caksoylar/keymap-drawer).
> See the `keymap-drawer/` folder for SVG renders of each layer.

### Layer 0: Base

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│ MEH+  │   Q   │   W   │   E   │   R   │   T   │   │   Y   │   U   │   I   │   O   │       │ GAME  │
│ ESC   │       │       │       │       │       │   │       │       │       │       │       │ tog   │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ BSPC  │ GUI   │ ALT   │ CTRL  │ SHIFT │ MEH   │   │ MEH   │ SHIFT │ CTRL  │ ALT   │   P   │       │
│       │   A   │   S   │   D   │   F   │   G   │   │   H   │   J   │   K   │   L   │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   Z   │   X   │   C   │   V   │   B   │   │   N   │   M   │   ,   │   .   │ GUI   │       │
│       │       │       │       │       │       │   │       │       │       │       │   '   │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │ ESC   │ TAB   │ SPACE │   │ ENTER │ BSPC  │ DEL   │
                        │ Media │ Func  │ Nav   │   │ Num   │ Sym   │ Sys   │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 1: Navigation

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│       │       │       │       │       │       │   │ HOME  │ PG DN │ PG UP │  END  │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │  GUI  │  ALT  │ CTRL  │ SHIFT │  MEH  │   │   ←   │   ↓   │   ↑   │   →   │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │       │       │       │       │       │   │  INS  │       │       │  DEL  │       │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │       │       │ ▓▓▓▓▓ │   │       │       │       │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 2: Function Keys

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│       │       │       │       │       │       │   │  F12  │  F7   │  F8   │  F9   │ PRTSC │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │  GUI  │  ALT  │ CTRL  │ SHIFT │  MEH  │   │  F11  │  F4   │  F5   │  F6   │ SCRLK │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │       │       │       │       │       │   │  F10  │  F1   │  F2   │  F3   │ PAUSE │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │       │ ▓▓▓▓▓ │       │   │       │       │       │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 3: Media

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│       │       │       │       │       │       │   │       │       │       │       │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │  GUI  │  ALT  │ CTRL  │ SHIFT │  MEH  │   │  ⏮   │  🔉  │  🔊  │  ⏭   │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │       │       │       │       │       │   │       │       │       │       │       │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │ ▓▓▓▓▓ │       │       │   │  ⏯   │  🔇  │       │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 4: Numbers

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│       │   [   │   7   │   8   │   9   │   ]   │   │       │       │       │       │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   ;   │   4   │   5   │   6   │   =   │   │  MEH  │ SHIFT │ CTRL  │  ALT  │  GUI  │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   `   │   1   │   2   │   3   │   \   │   │       │       │       │       │       │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │   .   │   0   │   -   │   │ ▓▓▓▓▓ │       │       │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 5: Symbols

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│       │   {   │   &   │   *   │   (   │   }   │   │       │       │       │       │       │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   :   │   $   │   %   │   ^   │   +   │   │  MEH  │ SHIFT │ CTRL  │  ALT  │  GUI  │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │   ~   │   !   │   @   │   #   │   |   │   │       │       │       │       │       │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │   (   │   )   │   _   │   │       │ ▓▓▓▓▓ │       │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 6: System

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│ BOOT  │ BT CLR│       │       │       │       │   │       │       │       │       │ BT CLR│ BOOT  │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ RESET │ BT 4  │ BT 3  │ BT 2  │ BT 1  │ BT 0  │   │ BT 0  │ BT 1  │ BT 2  │ BT 3  │ BT 4  │ RESET │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│       │       │       │       │       │       │   │       │       │       │       │       │       │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │       │       │       │   │       │       │ ▓▓▓▓▓ │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

### Layer 7: Gaming

```
┌───────┬───────┬───────┬───────┬───────┬───────┐   ┌───────┬───────┬───────┬───────┬───────┬───────┐
│  TAB  │   T   │   Q   │   W   │   E   │   R   │   │   Y   │   U   │   I   │   O   │       │ GAME  │
│       │       │       │       │       │       │   │       │       │       │       │       │ tog   │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ CTRL  │   G   │   A   │   S   │   D   │   F   │   │   H   │   J   │   K   │   L   │   P   │       │
├───────┼───────┼───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┼───────┼───────┤
│ SHIFT │   B   │   Z   │   X   │   C   │   V   │   │   N   │   M   │   ,   │   .   │   /   │   '   │
└───────┴───────┴───────┼───────┼───────┼───────┤   ├───────┼───────┼───────┼───────┴───────┴───────┘
                        │  ESC  │  ALT  │ SPACE │   │ ENTER │ BSPC  │  DEL  │
                        └───────┴───────┴───────┘   └───────┴───────┴───────┘
```

**Note**: Gaming layer has no home row mods - all keys send their literal values. WASD is shifted right for ergonomic hand position.

## Building

The firmware is built automatically via GitHub Actions. To build locally:

1. Set up ZMK development environment
2. Run `west build -b nice_nano_v2 -- -DSHIELD=corne_left`
3. Run `west build -b nice_nano_v2 -- -DSHIELD=corne_right`

## Flashing

1. Connect the keyboard via USB
2. Double-tap reset to enter bootloader mode
3. Copy the `.uf2` file to the mounted drive

## Customization

See [AGENT.md](AGENT.md) for instructions on how to customize this keymap.

## Credits

- Original QMK keymap: [funkymonkeymonk/qmk_keymap](https://github.com/funkymonkeymonk/qmk_keymap)
- Inspired by [Miryoku](https://github.com/manna-harbour/miryoku)
- Keymap visualization: [keymap-drawer](https://github.com/caksoylar/keymap-drawer)
