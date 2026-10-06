{ pkgs, lib, ... }:
{
  imports = [
    ./nix.nix
    ./nix-ld.nix
    ./direnv.nix
    ./ssh.nix
  ];

  environment.etc.certfile = {
    source = "/etc/ssl/certs/ca-bundle.crt";
    target = "ssl/cert.pem";
  };

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

  programs.bash.enable = true;
  programs.fish.enable = true;
}
