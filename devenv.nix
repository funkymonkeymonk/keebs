{ pkgs, ... }:

{
  cachix.enable = false;

  packages = [
    pkgs.yamllint
    pkgs.pre-commit
    # Essential tools
    pkgs.git
    pkgs.gh  # GitHub CLI
    # ZMK CLI
    pkgs.uv
    # Docker for local builds
    pkgs.docker
    pkgs.docker-compose
  ];

  pre-commit.hooks = {
    yamllint = {
      enable = true;
      entry = "${pkgs.yamllint}/bin/yamllint";
      files = "\\.(ya?ml)$";
      args = [ "-c" ".yamllint.yaml" ];
    };
  };

  # Install ZMK CLI using uv
  scripts.zmk-install.exec = "uv tool install zmk";
  scripts.zmk-docker-build.exec = "scripts/docker-build.sh";

  # Enable devenv's pre-commit integration
  enterShell = ''
    echo "🔧 ZMK Development Environment Ready!"
    echo "Available tools: yamllint, pre-commit, git, gh, uv, docker"
    echo ""
    echo "To install pre-commit hooks: pre-commit install"
    echo "To run yamllint manually: yamllint ."
    echo ""
    echo "🎹 Build Options:"
    echo "1. GitHub Actions (push → auto-build): git push origin main"
    echo "2. Docker Local Build: zmk-docker-build --shield your_keyboard"
    echo ""
    echo "📋 Configuration: Edit build.yaml to set keyboards"
    echo "🐳 Docker builds read from same build.yaml as GHA"
    echo "   Docker automatically starts colima and stops on exit"
  '';

  # Colima process management
  processes.colima = {
    exec = "colima start --cpu 4 --memory 4";
  };
}
