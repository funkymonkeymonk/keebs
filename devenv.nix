{ pkgs, ... }:

{
  cachix.enable = false;

  packages = [
    pkgs.yamllint
    pkgs.pre-commit
  ];

  pre-commit.hooks = {
    yamllint = {
      enable = true;
      entry = "${pkgs.yamllint}/bin/yamllint";
      files = "\\.(ya?ml)$";
      args = [ "-c" ".yamllint.yaml" ];
    };
  };

  # Enable devenv's pre-commit integration
  enterShell = ''
    echo "🔧 Development environment ready!"
    echo "Available tools: yamllint, pre-commit"
    echo ""
    echo "To install pre-commit hooks run: pre-commit install"
    echo "To run yamllint manually: yamllint ."
  '';
}
