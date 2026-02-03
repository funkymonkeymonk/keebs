# QMK to ZMK Keymap Port Design

**Date:** 2026-02-02
**Source:** Keebio Iris CE QMK keymap (funkymonkeymonk/qmk_keymap)
**Target:** Corne (crkbd) with nice!nano v2

## Overview

This design adapts a Miryoku-style QMK keymap from an Iris CE (56 keys) to a Corne (42 keys), consolidating 8 layers into a more focused 8-layer layout optimized for the smaller form factor.

## Design Principles

1. **Miryoku-style layer access**: One hand holds the layer key, opposite hand has the content
2. **Home row mods**: GACS pattern (GUI, Alt, Ctrl, Shift) + Meh on inner columns
3. **Gaming-friendly**: Dedicated toggle layer without home row mods for WASD gaming
4. **Minimal outer columns**: Empty outer keys except for essential functions

## Layer Summary

| Layer | Name       | Access              | Content Side        |
|-------|------------|---------------------|---------------------|
| 0     | Base       | Default             | Both (home row mods)|
| 1     | Navigation | Left Space hold     | Right hand          |
| 2     | Function   | Left Tab hold       | Right hand          |
| 3     | Media      | Left Esc hold       | Right hand          |
| 4     | Numbers    | Right Enter hold    | Left hand           |
| 5     | Symbols    | Right Bspc hold     | Left hand           |
| 6     | System     | Right Del hold      | Both (mirrored)     |
| 7     | Gaming     | Toggle (top-right)  | Left shifted, Right normal |

## Thumb Cluster Layout

```
Left:                              Right:
+----------+----------+----------+ +----------+----------+----------+
| Esc      | Tab      | Space    | | Enter    | Bspc     | Del      |
| /Media   | /Func    | /Nav     | | /Num     | /Sym     | /Sys     |
+----------+----------+----------+ +----------+----------+----------+
```

## Layer Definitions

### Layer 0: Base (Home Row Mods)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
| MEH+  |   Q   |   W   |   E   |   R   |   T   |   |   Y   |   U   |   I   |   O   |       | TG(7) |
| ESC   |       |       |       |       |       |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
| BSPC  | GUI/A | ALT/S | CTL/D | SFT/F | MEH/G |   | MEH/H | SFT/J | CTL/K | ALT/L |   P   |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   Z   |   X   |   C   |   V   |   B   |   |   N   |   M   |   ,   |   .   | GUI/' |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        | ESC/  | TAB/  | SPC/  |   | ENT/  | BSPC/ | DEL/  |
                        | Media | Func  | Nav   |   | Num   | Sym   | Sys   |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- MEH+ESC macro on top-left (sends Ctrl+Alt+Shift+Escape)
- Home row mods: GUI/A, ALT/S, CTL/D, SFT/F, MEH/G (mirrored on right)
- P moved to home row for better pinky reach
- GUI/' on bottom-right (tap for apostrophe, hold for GUI)
- Gaming toggle on top-right corner
- Empty outer columns except for functional keys

### Layer 1: Navigation (Left Space hold -> Right hand)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   | HOME  | PG_DN | PG_UP |  END  |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |  GUI  |  ALT  | CTRL  | SHFT  |  MEH  |   |   <-  |   v   |   ^   |  ->   |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   |  INS  |       |       |  DEL  |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        |       |       | ##### |   |       |       |       |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- Vim-style arrows on HJKL positions
- Home/PgDn/PgUp/End on top row aligned with arrows
- Left hand modifiers for combining with nav keys (e.g., Shift+Arrow for selection)

### Layer 2: Function (Left Tab hold -> Right hand)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   |  F12  |  F7   |  F8   |  F9   | PRTSC |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |  GUI  |  ALT  | CTRL  | SHFT  |  MEH  |   |  F11  |  F4   |  F5   |  F6   | SCRLK |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   |  F10  |  F1   |  F2   |  F3   | PAUSE |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        |       | ##### |       |   |       |       |       |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- F-keys in 3x3 numpad-style grid
- F10-F12 on outer column for easy access
- Print Screen, Scroll Lock, Pause on far right

### Layer 3: Media (Left Esc hold -> Right hand)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |  GUI  |  ALT  | CTRL  | SHFT  |  MEH  |   |  PREV | VOL_DN| VOL_UP|  NEXT |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        | ##### |       |       |   | PLAY  | MUTE  |       |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- Media controls on home row (aligned with nav layer arrows)
- Play/Pause and Mute on thumb cluster for easy access

### Layer 4: Numbers (Right Enter hold -> Left hand)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   [   |   7   |   8   |   9   |   ]   |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   ;   |   4   |   5   |   6   |   =   |   |  MEH  | SHFT  | CTRL  |  ALT  |  GUI  |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   `   |   1   |   2   |   3   |   \   |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        |   .   |   0   |   -   |   | ##### |       |       |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- Numpad-style number layout (789/456/123)
- Brackets, semicolon, equals, grave, backslash on edges
- Dot, zero, minus on thumb cluster

### Layer 5: Symbols (Right Bspc hold -> Left hand)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   {   |   &   |   *   |   (   |   }   |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   :   |   $   |   %   |   ^   |   +   |   |  MEH  | SHFT  | CTRL  |  ALT  |  GUI  |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |   ~   |   !   |   @   |   #   |   |   |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        |   (   |   )   |   _   |   |       | ##### |       |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- Shifted versions of number layer in same positions
- Braces, colon, plus, tilde, pipe on edges
- Parentheses, underscore on thumb cluster

### Layer 6: System (Right Del hold -> Both hands)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
| BOOT  | BT_CL |       |       |       |       |   |       |       |       |       | BT_CL | BOOT  |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
| RESET | BT_4  | BT_3  | BT_2  | BT_1  | BT_0  |   | BT_0  | BT_1  | BT_2  | BT_3  | BT_4  | RESET |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|       |       |       |       |       |       |   |       |       |       |       |       |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        |       |       |       |   |       |       | ##### |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- Mirrored on both sides for split keyboard safety
- Bluetooth profiles 0-4 on home row
- BT_CL (clear) on top row next to bootloader
- Bootloader and Reset accessible from either half

### Layer 7: Gaming (Toggle from top-right)

```
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
|  TAB  |   T   |   Q   |   W   |   E   |   R   |   |   Y   |   U   |   I   |   O   |       | TG(7) |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
| CTRL  |   G   |   A   |   S   |   D   |   F   |   |   H   |   J   |   K   |   L   |   P   |       |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
| SHFT  |   B   |   Z   |   X   |   C   |   V   |   |   N   |   M   |   ,   |   .   |   /   |   '   |
+-------+-------+-------+-------+-------+-------+   +-------+-------+-------+-------+-------+-------+
                        |  ESC  |  ALT  |  SPC  |   |  ENT  | BSPC  |  DEL  |
                        +-------+-------+-------+   +-------+-------+-------+
```

**Features:**
- **No home row mods** - keys send their literal values for WASD gaming
- Left side shifted right for ergonomic hand position
- T/G/B column for common game keys (grenade, etc.)
- Tab/Ctrl/Shift on outer column
- Full right side for typing in chat
- TG(7) on right to toggle back to base layer

## Custom Behaviors

### MEH+ESC Macro
Sends Ctrl+Alt+Shift+Escape simultaneously. Useful for app launchers like Alfred/Raycast.

### Home Row Mods (hold-tap)
- Tapping term: 200ms
- Quick-tap: 100ms
- Flavor: balanced

### GUI/' (hold-tap)
- Tap: Apostrophe (')
- Hold: Right GUI (Cmd/Win)

## Porting Notes

### Key Differences from Iris CE
1. **14 fewer keys**: Removed number row, adapted layout
2. **Consolidated layers**: Similar functionality in fewer layers
3. **Gaming layer preserved**: Critical for Tabletop Simulator and other games
4. **Meh modifier**: Kept on G/H for hyper-key functionality

### ZMK-Specific Considerations
1. Using `&kp` for regular keys
2. Using `&hm` (home_row_mods behavior) for mod-tap
3. Using `&lt` for layer-tap
4. Using `&tog` for gaming layer toggle
5. Using `&bt` for Bluetooth controls
6. Using `&bootloader` and `&sys_reset` for system functions
7. Custom macro for MEH+ESC combo key
