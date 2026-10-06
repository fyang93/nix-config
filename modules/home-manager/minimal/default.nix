{ pkgs, inputs, username, ... }:
{
  imports = [
    ./shell
    ./git.nix
    ./archive.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    dig # DNS lookup
    ripgrep
    fd
    jq

    just
    uv
    bun
    nodejs_22
    gnumake
    gcc

    inputs.nixpkgs-herdr.legacyPackages.${pkgs.stdenv.hostPlatform.system}.herdr

    # LSP: https://opencode.ai/docs/lsp/
    pyright
    deno
    nixd
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05";
}
