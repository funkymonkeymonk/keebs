# Corne Dongle Configuration for MDBT50Q-CX

This directory contains the ZMK shield configuration for using a Raytac MDBT50Q-CX USB dongle as the central device for the Corne keyboard.

## Files

- `Kconfig.shield` - Shield configuration definitions
- `Kconfig.defconfig` - Default Kconfig settings for the dongle
- `corne_dongle.overlay` - Device tree overlay defining the mock kscan and matrix transform

## Hardware

The MDBT50Q-CX is a USB-C dongle featuring:
- Nordic nRF52840 SoC
- USB-C connector
- Built-in Nordic DFU bootloader (no UF2)
- Single button for entering DFU mode
- Status LED

## Important Notes

### DFU vs UF2

Unlike the nice!nano which uses UF2 bootloader (drag-and-drop), the MDBT50Q-CX uses Nordic's DFU (Device Firmware Update) protocol. This requires:
- nRF Connect Desktop (GUI) or adafruit-nrfutil (CLI) to flash
- Entering DFU mode by holding the button while plugging in

### DCDC Disable Required

The MDBT50Q-CX requires DCDC to be disabled for proper operation:
```
CONFIG_BOARD_ENABLE_DCDC=n
CONFIG_BOARD_ENABLE_DCDC_HV=n
```

This is already configured in `corne_dongle.conf`.

## Flashing Instructions

### Using adafruit-nrfutil (CLI)

1. Build the firmware:
   ```bash
   west build -b nrf52840dongle_nrf52840 -- -DSHIELD=corne_dongle
   ```

2. Enter DFU mode on the dongle:
   - Hold the button
   - Plug into USB
   - Wait for LED to turn on (~1 second)
   - Release button

3. Flash the firmware:
   ```bash
   adafruit-nrfutil dfu serial --package build/zephyr/zephyr.hex --port /dev/ttyACM0
   ```
   Or use the helper script:
   ```bash
   ./flash-dongle.sh build/zephyr/zephyr.hex
   ```

### Using nRF Connect Desktop (GUI)

1. Build the firmware (same as above)

2. Enter DFU mode on the dongle

3. Open nRF Connect Desktop → Programmer

4. Click "SELECT DEVICE" → "Open DFU Bootloader"

5. Drag `build/zephyr/zephyr.hex` to the File area

6. Click "Write"

## Pairing

After flashing the dongle and keyboard halves:

1. Flash `settings_reset` to all devices first (clears old bonds)
2. Flash the dongle with `corne_dongle` shield
3. Flash both keyboard halves with the peripheral firmware (see build.yaml)
4. Power on all devices - they should pair automatically

## References

- [Raytac MDBT50Q-CX User Manual](https://www.raytac.com/news/ins.php?index_id=175)
- [ZMK Dongle Documentation](https://zmk.dev/docs/development/hardware-integration/dongle)
- [MDBT50Q-CX Product Page](https://www.raytac.com/product/ins.php?index_id=156)
