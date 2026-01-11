{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    # replacement of htop/nmon
    ./btop.nix
    ./bottom.nix
  ];

  programs = {
    # A cross-shell prompt
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # A modern replacement for screen/tmux
    zellij.enable = true;
  };
}
