{ pkgs, username, lib, ... }:
{
  imports = [
    ./shell
    ./git.nix
    ./archive.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    ripgrep
    fd
    jq

    just
    uv
    bun
    fnm # Node.js version manager (official nodejs.org builds)

    herdr # Herdr TUI
    herdr-core # hc CLI / core service
    #(pkgs.callPackage ./herdr.nix { })
  ];

  home.username = username;
  home.homeDirectory = lib.mkDefault "/home/${username}";

  home.stateVersion = "26.05";
}
