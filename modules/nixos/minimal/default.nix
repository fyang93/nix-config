{ pkgs, lib, ... }:
{
  imports = [
    ./nix.nix
    ./nix-ld.nix
    ./direnv.nix
    ./ssh.nix
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    wget
    curl
    tree
    just
    usbutils # lsusb, etc.
  ];

  programs.vim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];
}
