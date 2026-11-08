{ pkgs, username, ... }:
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

    (pkgs.callPackage ./herdr.nix { })
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";
}
