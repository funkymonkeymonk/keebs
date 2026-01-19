# ZMK Firmware Configuration

Standard ZMK setup using official workflows and local Docker builds.

## Keyboard

- **Keyboard**: Typeractive Corne (42-key split ergonomic)
- **Layout**: Modified Miryoku  
- **Controller**: Nice!Nano v2

## 🎹 Quick Start

### 1. Enter Development Environment
```bash
devenv shell
```

### 2. Configure Keyboard

Edit `build.yaml` to set your keyboard configuration:
```yaml
include:
  - board: nice_nano_v2
    shield: corne_left nice_view_adapter nice_view
  - board: nice_nano_v2  
    shield: corne_right nice_view_adapter nice_view
```

### 3. Choose Build Method

#### 🐳 **Docker Build (Recommended)**
Immediate local builds, same process as GitHub Actions:
```bash
zmk-docker-build --shield corne_left
zmk-docker-build --shield corne_right
```

#### 🌐 **GitHub Actions**
Automatic builds on push, artifact downloads:
```bash
git push origin main
# Download from Actions tab
```

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

## 📁 Project Structure

```
.
├── .github/workflows/
│   ├── build.yml          # Official ZMK workflow
│   └── opencode.yml       # OpenCode integration
├── scripts/
│   └── docker-build.sh    # Local Docker build script
├── devenv.nix           # Minimal Nix environment
├── build.yaml            # ZMK build configuration
└── config/               # Keymap and config files
```

## ⚡ Setup Overview

| Method | Setup | Speed | Dependencies |
|--------|-------|------|-------------|
| Docker | Minimal | Immediate | Docker only |
| GitHub Actions | Minimal | Queue | None |

## 🎯 Standard ZMK Pattern

This follows the **official ZMK pattern** used by 761+ repositories:

### ✅ **GitHub Actions**
- Uses official `zmkfirmware/zmk/.github/workflows/build-user-config.yml@v0.3`
- No maintenance, always up-to-date
- Automatic artifact management

### ✅ **Docker Build**
- Mirrors exact GHA process  
- Reads same `build.yaml` configuration
- Immediate local results

### ✅ **Configuration**
Both methods read from identical `build.yaml` format:
- No duplicate configuration
- Consistent builds across environments

## 🔧 Available Scripts

- `zmk-install`: Install ZMK CLI
- `zmk-docker-build`: Local Docker build

## 🚀 Next Steps

1. **Configure**: Edit `build.yaml` with your keyboard
2. **Test Local**: Use Docker builds for quick iteration  
3. **Push Changes**: Trigger GitHub Actions for CI/CD
4. **Flash Firmware**: Copy UF2 files to your Nice!Nano

## References

- [ZMK Documentation](https://zmk.dev/)
- [Miryoku Layout](https://github.com/manna-harbour/miryoku)
- [Typeractive Corne](https://typeractive.com/products/corne)
- [Official Build Workflow](https://github.com/zmkfirmware/zmk/blob/main/.github/workflows/build-user-config.yml)
