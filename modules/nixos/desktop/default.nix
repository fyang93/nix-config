{ pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./audio.nix
    ./font.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };
}
