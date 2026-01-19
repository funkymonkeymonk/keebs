#!/usr/bin/env bash

# ZMK Docker Build Script
# Uses ZMK's official Docker image for building firmware locally

set -e

KEYBOARD_NAME=""
BOARD="nice_nano"
SHIELD=""
ZMK_CONFIG=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Help function
show_help() {
    echo "🎹 ZMK Docker Build Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Required:"
    echo "  -s, --shield SHIELD      Keyboard shield name (e.g., kyria_left, crkbd)"
    echo ""
    echo "Optional:"
    echo "  -b, --board BOARD        Board name (default: nice_nano)"
    echo "  -c, --config PATH        Path to config directory"
    echo "  -h, --help              Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 --shield kyria_left"
    echo "  $0 -s crkbd -c /path/to/config"
    echo "  $0 -s my_keyboard --board nice_nano_v2"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--shield)
            SHIELD="$2"
            shift 2
            ;;
        -b|--board)
            BOARD="$2"
            shift 2
            ;;
        -c|--config)
            ZMK_CONFIG="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check required arguments
if [ -z "$SHIELD" ]; then
    echo "❌ Error: Shield name is required"
    show_help
    exit 1
fi

echo "🎹 Building ZMK firmware with Docker..."
echo "   Board: $BOARD"
echo "   Shield: $SHIELD"
if [ -n "$ZMK_CONFIG" ]; then
    echo "   Config: $ZMK_CONFIG"
fi
echo ""

# Build command (mirroring GHA)
BUILD_CMD="west build -b $BOARD -- -DSHIELD=$SHIELD -DZMK_CONFIG=/work/config"

# Extract shields from build.yaml if it exists
if [ -f "$REPO_DIR/build.yaml" ] && [ -z "$ZMK_CONFIG" ]; then
    echo "📋 Reading shields from build.yaml..."
    
    # Parse YAML to extract board/shield combinations
    while IFS= read -r line; do
        if [[ "$line" =~ ^[[:space:]]*board:[[:space:]]*([a-z0-9_]+) ]]; then
            CURRENT_BOARD="${BASH_REMATCH[1]}"
        elif [[ "$line" =~ ^[[:space:]]*shield:[[:space:]]*(.+) ]]; then
            CURRENT_SHIELD="${BASH_REMATCH[1]}"
        elif [[ "$line" =~ ^[[:space:]]*snippet:[[:space:]]*(.+) ]]; then
            CURRENT_SNIPPET="${BASH_REMATCH[1]}"
        fi
    done < "$REPO_DIR/build.yaml"
    
    # Use the parsed values if we have them
    if [ -n "$CURRENT_BOARD" ] && [ -n "$CURRENT_SHIELD" ]; then
        BOARD="$CURRENT_BOARD"
        SHIELD="$CURRENT_SHIELD"
        echo "   Using board: $BOARD"
        echo "   Using shield: $SHIELD"
        if [ -n "$CURRENT_SNIPPET" ]; then
            echo "   Using snippet: $CURRENT_SNIPPET"
        fi
    fi
fi

echo "🐳 Running Docker build (mirroring GHA process)..."

# Mirror the exact GHA process
docker run --rm \
    -v "$REPO_DIR:/work" \
    -w /work \
    zmkfirmware/zmk-build:stable \
    bash -c "
    set -e
    echo '🔧 Initializing ZMK Workspace...'
    west init -l app
    
    echo '📦 Updating dependencies...'
    west update
    
    echo '📤 Exporting Zephyr CMake package...'
    west zephyr-export
    
    echo '🏗️ Building firmware...'
    cd app
    $BUILD_CMD
    "

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build completed successfully!"
    echo "📁 Firmware files should be available in: $REPO_DIR/zmk/app/build/zephyr/"
    
    # Show the generated files
    if [ -d "$REPO_DIR/zmk/app/build/zephyr" ]; then
        echo "📋 Generated firmware files:"
        ls -la "$REPO_DIR/zmk/app/build/zephyr/"*.uf2 "$REPO_DIR/zmk/app/build/zephyr/"*.hex "$REPO_DIR/zmk/app/build/zephyr/"*.bin 2>/dev/null || echo "   No firmware files found"
    fi
    
    echo ""
    echo "🔨 To flash your Nice!Nano:"
    echo "   1. Double-tap the reset button on your Nice!Nano"
    echo "   2. Copy the .uf2 file to the USB mass storage device"
else
    echo "❌ Build failed!"
    exit 1
fi