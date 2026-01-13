# ZMK Configuration Repository

This repository contains the ZMK firmware configuration for a Typeractive Corne keyboard with a modified Miryoku layout.

## Keyboard

- **Keyboard**: Typeractive Corne (42-key split ergonomic)
- **Layout**: Modified Miryoku
- **Controller**: Nice!Nano or compatible

## Setup

### Local Development

1. Install [devenv](https://devenv.sh/)
2. Run `devenv shell` to enter the development environment
3. Use Task commands to build firmware locally

### Building Firmware

#### Locally with Task

```bash
# Enter development environment
devenv shell

# Build firmware for both halves
task build

# Build specific half only
task build-left
task build-right

# Clean build artifacts
task clean

# Show build status
task status

# Watch for config changes and rebuild
task watch

# Show all available tasks
task help
```

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
├── .github/workflows/        # CI/CD workflows
├── devenv.nix               # Development environment
├── build.yaml               # Build configuration
└── build.sh                 # Local build script
```

## References

- [ZMK Documentation](https://zmk.dev/)
- [Miryoku Layout](https://github.com/manna-harbour/miryoku)
- [Typeractive Corne](https://typeractive.com/products/corne)