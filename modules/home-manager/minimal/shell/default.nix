{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    # replacement of htop/nmon
    ./btop.nix
    ./bottom.nix
  ];

  home.packages = with pkgs; [
    krabby
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    BUN_INSTALL = "$HOME/.bun";
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
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      fileWidgetCommand = "fd --type f";
      changeDirWidgetCommand = "fd --type d";
      defaultOptions = [
        "--layout=reverse"
        "--border"
        "--height=~60%"
      ];
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    # A smarter cd command
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    # A modern replacement for ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat.enable = true;

    # A modern replacement for screen/tmux
    zellij.enable = true;
  };
}
