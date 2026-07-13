{ pkgs, username, ... }:
{
  imports = [
    ./shell
    ./zellij
    ./git.nix
    ./archive.nix
    ./dev.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    dig # DNS lookup
    fd
    ripgrep
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";
}
