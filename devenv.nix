{ pkgs, lib, ... }:

let
  # Build adafruit-nrfutil with unfree license allowed
  adafruit-nrfutil = pkgs.adafruit-nrfutil.overrideAttrs (old: {
    meta = old.meta // { license = lib.licenses.mit; };
  });
in
{
  cachix.enable = false;

  packages = [
    pkgs.yamllint
    pkgs.pre-commit
    pkgs.git
    pkgs.gh
    pkgs.docker-client
    pkgs.act
    pkgs.colima
    pkgs.go-task
    # Bootloader flashing tools
    adafruit-nrfutil
  ];

  pre-commit.hooks = {
    yamllint = {
      enable = true;
      entry = "${pkgs.yamllint}/bin/yamllint";
      files = "\\.(ya?ml)$";
      args = [ "-c" ".yamllint.yaml" ];
    };
  };
}
