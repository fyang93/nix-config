{ pkgs, ... }:
{
  imports = [
    ./fish.nix
  ];

  home.packages = with pkgs; [
    krabby
    tinty
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    UV_CACHE_DIR = "$HOME/.cache/uv";
    NPM_CONFIG_PREFIX = "$HOME/.npm";
    NPM_CONFIG_CACHE = "$HOME/.cache/npm";
    BUN_INSTALL = "$HOME/.bun";
    BUN_INSTALL_CACHE_DIR = "$HOME/.cache/bun";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$NPM_CONFIG_PREFIX/bin"
    "$BUN_INSTALL/bin"
    # fnm default node, for non-interactive shells
    "$HOME/.local/share/fnm/aliases/default/bin"
  ];

  programs = {
    # A cross-shell prompt
    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      fileWidget.command = "fd --type f";
      changeDirWidget.command = "fd --type d";
      enableFishIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableFishIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;
  };
}
