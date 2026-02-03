# Agent Instructions: Corne Keymap Customization

This document provides instructions for AI agents (like Claude, GPT, etc.) to help customize this ZMK keymap.

## Project Overview

This is a ZMK firmware configuration for a Corne (crkbd) keyboard with:
- **42 keys** (6 columns x 3 rows + 3 thumb keys per side)
- **nice!nano v2** controller
- **8 layers** with Miryoku-style organization

## Key Files

| File | Purpose |
|------|---------|
| `config/corne.keymap` | Main keymap definition |
| `config/corne.conf` | ZMK configuration options |
| `build.yaml` | GitHub Actions build matrix |
| `README.md` | Documentation with layer visualizations |
| `docs/plans/` | Design documents |

## Understanding the Keymap Structure

### Layer Organization

```
Layer 0: Base      - Default typing layer with home row mods
Layer 1: Nav       - Navigation (arrows, page up/down, home/end)
Layer 2: Func      - Function keys (F1-F12)
Layer 3: Media     - Media controls (play, volume, etc.)
Layer 4: Num       - Numbers in numpad layout
Layer 5: Sym       - Symbols (shifted numbers)
Layer 6: Sys       - System (Bluetooth, bootloader, reset)
Layer 7: Game      - Gaming mode (no home row mods)
```

### Thumb Cluster Pattern

```
Left Hand:                    Right Hand:
┌─────────┬─────────┬─────────┐   ┌─────────┬─────────┬─────────┐
│ ESC     │ TAB     │ SPACE   │   │ ENTER   │ BSPC    │ DEL     │
│ /Media  │ /Func   │ /Nav    │   │ /Num    │ /Sym    │ /Sys    │
└─────────┴─────────┴─────────┘   └─────────┴─────────┴─────────┘

- Left thumb keys access layers with content on RIGHT hand
- Right thumb keys access layers with content on LEFT hand
```

### Key Position Reference

```
Row 0:  0   1   2   3   4   5       6   7   8   9  10  11
Row 1: 12  13  14  15  16  17      18  19  20  21  22  23
Row 2: 24  25  26  27  28  29      30  31  32  33  34  35
Thumb:             36  37  38      39  40  41
```

## Common Customization Tasks

### 1. Moving a Key

To move a key to a different position:

1. Find the key in the appropriate layer
2. Locate its position in the bindings grid
3. Swap with the target position or replace with `&none`

**Example**: Move P from position 22 to position 10

```c
// Before
&kp Y &kp U &kp I &kp O &none &tog GAME
...
&hm MEH H &hm RSFT J &hm RCTL K &hm RALT L &kp P &none

// After
&kp Y &kp U &kp I &kp O &kp P &tog GAME
...
&hm MEH H &hm RSFT J &hm RCTL K &hm RALT L &none &none
```

### 2. Adding a New Layer

1. Define the layer number:
```c
#define NEWLAYER 8
```

2. Add a layer-tap to access it:
```c
&lt NEWLAYER key   // Hold for layer, tap for key
```

3. Create the layer definition:
```c
newlayer_name {
    display-name = "NewLayer";
    bindings = <
        // 42 bindings here
    >;
};
```

### 3. Changing Home Row Mods

The home row mods use the `&hm` behavior (hold-tap):

```c
// Format: &hm MODIFIER KEY
&hm LGUI A    // Hold = GUI, Tap = A
&hm LALT S    // Hold = Alt, Tap = S
&hm LCTL D    // Hold = Ctrl, Tap = D
&hm LSFT F    // Hold = Shift, Tap = F
```

To change timing:
```c
hm: home_row_mods {
    tapping-term-ms = <200>;   // Time to distinguish tap vs hold
    quick-tap-ms = <100>;      // Time for quick double-tap
    flavor = "balanced";       // Options: "balanced", "tap-preferred", "hold-preferred"
};
```

### 4. Adding Combos

Combos allow pressing multiple keys simultaneously to produce a different output:

```c
combos {
    compatible = "zmk,combos";
    
    combo_name {
        timeout-ms = <50>;
        key-positions = <13 14>;  // A + S
        bindings = <&kp ESCAPE>;
    };
};
```

### 5. Adding Macros

Macros send a sequence of keypresses:

```c
macros {
    my_macro: my_macro {
        compatible = "zmk,behavior-macro";
        #binding-cells = <0>;
        bindings = <&kp H &kp E &kp L &kp L &kp O>;
    };
};
```

Use with: `&my_macro` in the keymap.

### 6. Customizing the Gaming Layer

The gaming layer (Layer 7) is designed to be modified frequently based on the game being played.

**Common modifications:**
- Add number keys for hotbar access
- Add specific keybinds for game actions
- Adjust modifier positions

**Example**: Add numbers 1-5 to top row for Tabletop Simulator:
```c
game_layer {
    bindings = <
        &kp N1 &kp N2 &kp N3 &kp N4 &kp N5 &kp N6  ...
```

### 7. Bluetooth Profile Management

Bluetooth profiles are on Layer 6 (Sys):

```c
&bt BT_SEL 0   // Select profile 0
&bt BT_SEL 1   // Select profile 1
&bt BT_CLR     // Clear current profile
```

To add more profiles or rearrange:
- Profiles 0-4 are available (5 total)
- Current layout: BT_4, BT_3, BT_2, BT_1, BT_0 on home row

## ZMK Key Reference

### Common Key Codes

| Code | Description |
|------|-------------|
| `&kp X` | Regular keypress |
| `&none` | No action |
| `&trans` | Transparent (pass through to lower layer) |
| `&mo X` | Momentary layer X |
| `&tog X` | Toggle layer X |
| `&lt X KEY` | Layer-tap (hold for layer, tap for key) |
| `&mt MOD KEY` | Mod-tap (hold for modifier, tap for key) |
| `&hm MOD KEY` | Home row mod (custom behavior) |

### Modifiers

| Code | Modifier |
|------|----------|
| `LGUI` / `RGUI` | Command/Windows |
| `LALT` / `RALT` | Alt/Option |
| `LCTL` / `RCTL` | Control |
| `LSFT` / `RSFT` | Shift |
| `LC(LA(LSHIFT))` | Meh (Ctrl+Alt+Shift) |

### Special Keys

| Code | Key |
|------|-----|
| `&bootloader` | Enter bootloader mode |
| `&sys_reset` | System reset |
| `&bt BT_CLR` | Clear Bluetooth |
| `&bt BT_SEL X` | Select BT profile X |

## Workflow for Changes

1. **Describe the change** you want to make
2. **Identify the layer(s)** affected
3. **Locate the key position(s)** using the reference grid
4. **Make the edit** to `config/corne.keymap`
5. **Update README.md** if the change affects layer visualizations
6. **Test** by building firmware (GitHub Actions will do this automatically)

## Asking for Help

When asking for keymap customization help, please provide:

1. **Current behavior**: What the key/layer does now
2. **Desired behavior**: What you want it to do
3. **Context**: Why you need this change (helps suggest better solutions)
4. **Constraints**: Any keys/positions that must stay the same

**Example request:**
> "I want to add a dedicated screenshot key. Currently I use Cmd+Shift+4 on macOS. 
> I'd like it on the Media layer since I have empty keys there. 
> Position doesn't matter as long as it's on the right hand."

## Building and Testing

### GitHub Actions (Recommended)

Push changes to trigger automatic build:
```bash
git add config/corne.keymap
git commit -m "Update keymap: [description]"
git push
```

### Local Build

```bash
west build -b nice_nano_v2 -- -DSHIELD=corne_left
west build -b nice_nano_v2 -- -DSHIELD=corne_right
```

## Keymap Visualization

After making changes, the keymap visualization should be updated. This project uses [keymap-drawer](https://github.com/caksoylar/keymap-drawer) for automatic rendering.

The GitHub workflow will:
1. Parse `config/corne.keymap`
2. Generate SVG visualizations
3. Commit them to `keymap-drawer/` folder

## Resources

- [ZMK Documentation](https://zmk.dev/docs)
- [ZMK Keycodes](https://zmk.dev/docs/codes)
- [ZMK Behaviors](https://zmk.dev/docs/behaviors)
- [keymap-drawer](https://github.com/caksoylar/keymap-drawer)
- [Miryoku](https://github.com/manna-harbour/miryoku) - Layout inspiration
