{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    krabby
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    UV_CACHE_DIR = "$HOME/.cache/uv";
    BUN_INSTALL = "$HOME/.bun";
    BUN_INSTALL_CACHE_DIR = "$HOME/.cache/bun";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$BUN_INSTALL/bin"
  ];

  programs = {
    # A cross-shell prompt
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      fileWidgetCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      enableBashIntegration = false; # managed by ble.sh
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # A modern replacement for screen/tmux
    zellij.enable = true;
  };
}
