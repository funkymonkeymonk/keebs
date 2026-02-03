{ pkgs, ... }:

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
