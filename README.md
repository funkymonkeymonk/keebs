# ZMK Configuration Repository

This repository contains the ZMK firmware configuration for a Typeractive Corne keyboard with a modified Miryoku layout.

## Keyboard

- **Keyboard**: Typeractive Corne (42-key split ergonomic)
- **Layout**: Modified Miryoku
- **Controller**: Nice!Nano or compatible

## Setup

### Building Firmware

#### Via GitHub Actions

1. Push changes to this repository
2. GitHub Actions will automatically build the firmware
3. Download the firmware artifacts from the Actions tab

## Flashing

1. Put your keyboard into bootloader mode (double-tap the reset button)
2. Copy the appropriate `.uf2` file to the USB mass storage device
3. The keyboard will automatically restart with the new firmware

## Layout

This configuration uses a modified Miryoku layout with the following features:

- Base layer with standard QWERTY layout
- Navigation and media layers
- Symbol and number layers
- Function layer

## Repository Structure

```
├── config/                    # Keymap and configuration files
├── boards/shields/           # Keyboard definitions
└── .github/workflows/        # CI/CD workflows
```

## References

- [ZMK Documentation](https://zmk.dev/)
- [Miryoku Layout](https://github.com/manna-harbour/miryoku)
- [Typeractive Corne](https://typeractive.com/products/corne)