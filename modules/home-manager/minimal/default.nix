{ pkgs, username, ... }:
{
  imports = [
    ./shell
    ./zellij
    ./git.nix
    ./archive.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fd
    ripgrep
    just
    uv
    dig # DNS lookup
    fastfetchMinimal
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.05";
}
