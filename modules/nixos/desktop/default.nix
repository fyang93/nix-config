{ pkgs, ... }:
{
  imports = [
    ./kde.nix
    ./font.nix
    ./audio.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };
}
