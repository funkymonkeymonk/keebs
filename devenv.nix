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
    pkgs.dtc
    pkgs.dfu-util
    pkgs.python311Packages.west
    pkgs.pipx
  ];

  # https://devenv.sh/languages/
  languages = {
    python = {
      enable = true;
      venv.enable = true;
    };
    c.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
