{ pkgs, ... }:
{
  imports = [
    ./cosmic.nix
    ./font.nix
    ./audio.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };
}
