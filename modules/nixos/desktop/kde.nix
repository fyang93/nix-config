{ pkgs, ... }:
{
  services.xserver.enable = false; # optional
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # using wayland (preferred)
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    kate
  ];
}
