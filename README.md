# Corne ZMK Keymap

[![Build ZMK Firmware](https://github.com/funkymonkeymonk/keebs/actions/workflows/build.yml/badge.svg)](https://github.com/funkymonkeymonk/keebs/actions/workflows/build.yml)
[![Latest Release](https://img.shields.io/github/v/release/funkymonkeymonk/keebs?label=firmware)](https://github.com/funkymonkeymonk/keebs/releases/latest)

A Miryoku-inspired ZMK keymap for the Corne (crkbd) keyboard with nice!nano v2 controller.

## Download Firmware

**[Download Latest Firmware](https://github.com/funkymonkeymonk/keebs/releases/latest)** - Get the `.uf2` files for your keyboard.

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

## Dongle Setup (Optional)

This keymap supports using a USB dongle for improved battery life. The dongle acts as the central device, allowing both keyboard halves to be peripherals.

### Supported Dongles

- [Raytac MDBT50Q-CX](https://www.raytac.com/product/ins.php?index_id=156) (USB-C, nRF52840)
- [Raytac MDBT50Q-RX](https://www.raytac.com/product/ins.php?index_id=89) (USB-A, nRF52840)
- Any nRF52840 USB dongle with Nordic DFU bootloader

### Benefits

- **Improved battery life**: Both halves last ~5-8 months vs 2-4 weeks (left half as central)
- **Better connectivity**: Dongle stays plugged in, halves connect wirelessly
- **Travel friendly**: Use dongleless mode when traveling, switch anytime

### Flashing the Dongle (MDBT50Q-CX)

The MDBT50Q-CX uses Nordic's DFU bootloader (not UF2):

1. **Enter DFU mode**:
   - Hold the button on the dongle
   - Plug into USB while holding
   - Wait ~1 second until LED turns on
   - Release button (LED blinks continuously)

2. **Flash with nRF Connect** (GUI):
   - Open **nRF Connect Desktop → Programmer**
   - Click **SELECT DEVICE → Open DFU Bootloader**
   - Drag `zephyr.hex` into the File area
   - Click **Write**

3. **Flash with adafruit-nrfutil** (CLI):
   ```bash
   adafruit-nrfutil dfu serial --package firmware.hex --port /dev/ttyACM0
   ```

### Flashing Keyboard Halves (with Dongle)

When using a dongle, flash the peripheral firmware:

1. Download `nice_nano_v2-corne_left-peripheral-zmk.uf2` (or right)
2. Flash to keyboard halves as normal (double-tap reset, copy .uf2)
3. The halves will automatically pair with the dongle

### Switching Between Dongle/Dongleless

To switch modes, flash the `settings_reset` firmware to all devices (dongle + both halves), then flash the appropriate firmware.

### References

- [ZMK Dongle Documentation](https://zmk.dev/docs/development/hardware-integration/dongle)
- [Raytac MDBT50Q-CX User Manual](https://www.raytac.com/news/ins.php?index_id=175)

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

## Installation

### Download

1. Go to the [Latest Release](https://github.com/funkymonkeymonk/keebs/releases/latest)
2. **For dongleless setup** (default):
   - `nice_nano_v2-corne_left-nice_view_adapter-nice_view-zmk.uf2` (left half)
   - `nice_nano_v2-corne_right-nice_view_adapter-nice_view-zmk.uf2` (right half)
3. **For dongle setup**:
   - `nrf52840dongle_nrf52840-corne_dongle-zmk.hex` (dongle - flash via DFU)
   - `nice_nano_v2-corne_left-nice_view_adapter-nice_view-peripheral-zmk.uf2`
   - `nice_nano_v2-corne_right-nice_view_adapter-nice_view-peripheral-zmk.uf2`
4. `settings_reset.uf2` - For clearing Bluetooth bonds when switching modes

### Flashing

1. Connect the keyboard half via USB
2. Double-tap the reset button to enter bootloader mode
3. A drive named `NICENANO` will appear
4. Copy the appropriate `.uf2` file to the drive
5. The keyboard will automatically reboot
6. Repeat for the other half

## Building Locally

The firmware is built automatically via GitHub Actions. To build locally:

1. Set up ZMK development environment
2. Run `west build -b nice_nano_v2 -- -DSHIELD=corne_left`
3. Run `west build -b nice_nano_v2 -- -DSHIELD=corne_right`

## Customization

See [AGENT.md](AGENT.md) for instructions on how to customize this keymap.

## Credits

- Original QMK keymap: [funkymonkeymonk/qmk_keymap](https://github.com/funkymonkeymonk/qmk_keymap)
- Inspired by [Miryoku](https://github.com/manna-harbour/miryoku)
- Keymap visualization: [keymap-drawer](https://github.com/caksoylar/keymap-drawer)
