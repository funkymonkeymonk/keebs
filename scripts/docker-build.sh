#!/usr/bin/env bash

# ZMK Docker Build Script
# Uses ZMK's official Docker image for building firmware locally
# Automatically reads from build.yaml configuration

set -e

# Function to check if Docker is available and running
check_docker() {
    if ! command -v docker >/dev/null 2>&1; then
        echo "❌ Error: Docker is not installed or not in PATH"
        echo "   Please install Docker and try again"
        exit 1
    fi
    
    if ! docker info >/dev/null 2>&1; then
        echo "❌ Error: Docker daemon is not running"
        echo "   Please start Docker and try again"
        exit 1
    fi
}

# Function to build single configuration
build_single_config() {
    local board="$1"
    local shields="$2"
    local config_path="$3"
    
    # Default to repo config if no custom path
    if [ -z "$config_path" ]; then
        config_path="/work/config"
    fi
    
    # Build command - handle multiple shields properly
    BUILD_CMD="west build -b $board -- -DSHIELD=$shields -DZMK_CONFIG=$config_path"
    
    echo "🐳 Running Docker build..."
    
    # Mirror official ZMK GHA process
    docker run --rm \
        -v "$(dirname "$0")/../:/work" \
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
        echo "   ✅ Build successful!"
    else
        echo "   ❌ Build failed!"
        return 1
    fi
}

# Default values
BOARD=""
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
    echo "Optional:"
    echo "  -s, --shield SHIELD      Build specific shield (overrides build.yaml)"
    echo "  -b, --board BOARD        Board name (overrides build.yaml)"
    echo "  -c, --config PATH        Custom config directory"
    echo "  -h, --help              Show this help"
    echo ""
    echo "If no arguments provided, builds all configurations from build.yaml"
    echo ""
    echo "Examples:"
    echo "  $0                            # Build all from build.yaml"
    echo "  $0 --shield corne_left       # Build specific shield"
    echo "  $0 -s crkbd -b nice_nano_v2  # Custom board/shield"
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

# Check Docker availability
check_docker

echo "🎹 Building ZMK firmware with Docker..."

# Parse build.yaml if no specific shield provided
if [ -z "$SHIELD" ] && [ -f "$REPO_DIR/build.yaml" ]; then
    echo "📋 Reading configurations from build.yaml..."
    
    # Use yq if available, otherwise simple grep/awk approach
    if command -v yq >/dev/null 2>&1; then
        echo "   Using yq for YAML parsing"
        # Parse with yq
        IFS=$'\n' read -r -d '' -a configs <<< "$(yq eval '.include | map(.board + ":" + (.shield | join(" "))' "$REPO_DIR/build.yaml")"
        
        if [ ${#configs[@]} -gt 0 ] && [ "${configs[0]}" != "null" ]; then
            echo ""
            echo "🏗️ Building ${#configs[@]} configuration(s)..."
            
            for config in "${configs[@]}"; do
                if [ "$config" != "null" ]; then
                    IFS=':' read -r board shields <<< "$config"
                    echo ""
                    echo "--- Building: $board + $shields ---"
                    build_single_config "$board" "$shields" "$ZMK_CONFIG"
                fi
            done
            
            echo ""
            echo "✅ All builds completed!"
            echo "📁 Firmware files available in build directories"
            exit 0
        fi
    else
        echo "   Using awk for YAML parsing"
        # Use awk to parse the YAML structure properly
        declare -a configs
        
        # Extract board/shield combinations using awk
        while IFS= read -r line; do
            # Skip if not in include section
            if [[ "$line" != *"include:"* ]] && [[ "$line" != *"board:"* ]]; then
                continue
            fi
            
            # Look for board lines (indented with -)
            if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*board:[[:space:]]*([a-z0-9_]+) ]]; then
                board="${BASH_REMATCH[1]}"
                # Get shield from next line(s)
                shields=""
                while IFS= read -r next_line; do
                    if [[ "$next_line" =~ ^[[:space:]]*shield:[[:space:]]*(.+)[[:space:]]*$ ]] || [[ "$next_line" =~ ^[[:space:]]*shield:[[:space:]]*(.+)[[:space:]]*snippet: ]]; then
                        shields="${BASH_REMATCH[1]}"
                        # Add shields to configs
                        if [ -n "$shields" ]; then
                            configs+=("$board:$shields")
                            echo "   Found: $board + $shields"
                        fi
                        break
                    else
                        # Skip blank lines or comments
                        if [[ -n "$next_line" ]] && [[ ! "$next_line" =~ ^[[:space:]]*# ]]; then
                            break
                        fi
                    fi
                done
            fi
        done < "$REPO_DIR/build.yaml"
        
        # Build each configuration
        if [ ${#configs[@]} -gt 0 ]; then
            echo ""
            echo "🏗️ Building ${#configs[@]} configuration(s)..."
            
            for config in "${configs[@]}"; do
                IFS=':' read -r board shields <<< "$config"
                echo ""
                echo "--- Building: $board + $shields ---"
                build_single_config "$board" "$shields" "$ZMK_CONFIG"
            done
            
            echo ""
            echo "✅ All builds completed!"
            echo "📁 Firmware files available in build directories"
            exit 0
        fi
    fi
fi

# Build single configuration if shield specified
if [ -n "$SHIELD" ]; then
    if [ -z "$BOARD" ]; then
        BOARD="nice_nano_v2"  # Default board
    fi
    echo "   Board: $BOARD"
    echo "   Shield: $SHIELD"
    echo ""
    build_single_config "$BOARD" "$SHIELD" "$ZMK_CONFIG"
    exit 0
fi

# If we get here, no configuration found
echo "❌ Error: No configuration found"
echo "   Either provide --shield argument or create build.yaml"
show_help
exit 1