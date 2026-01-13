{
  pkgs,
  lib,
  config,
  ...
}:
{
  cachix.enable = false;
  # https://devenv.sh/packages/
  packages = [
    # ZMK build dependencies
    pkgs.dtc
    pkgs.dfu-util
    pkgs.python311Packages.west
    pkgs.cmake
    pkgs.ninja
    pkgs.gcc-arm-embedded
    pkgs.pyocd
    pkgs.gnumake
    pkgs.git

    # Additional tools for development
    pkgs.pipx
    pkgs.nodejs  # For ZMK Studio if needed
    pkgs.go-task # Task runner
    pkgs.yamllint # YAML linting and validation
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    pkgs.udev  # For device access (Linux only)
  ];

  # https://devenv.sh/languages/
  languages = {
    python = {
      enable = true;
      venv.enable = true;
    };
    c.enable = true;
  };

  # Environment variables for ZMK
  env = {
    ZEPHYR_TOOLCHAIN_VARIANT = "gnuarmemb";
    GNUARMEMB_TOOLCHAIN_PATH = "${pkgs.gcc-arm-embedded}";
    WEST_DIR = "${builtins.toString ./.}";
  };

  # Pre-shell hooks to setup environment
  enterShell = ''
    echo "ZMK Development Environment"
    echo "=========================="
    echo "Toolchain: GNU ARM Embedded"
    echo "Zephyr SDK: Available via nixpkgs"
    echo ""
    echo "Available commands:"
    task
  '';

  # See full reference at https://devenv.sh/reference/options/
}
