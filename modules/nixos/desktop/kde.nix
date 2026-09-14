{ pkgs, ... }:
{
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs.kdePackages; [
      xdg-desktop-portal-kde
    ];
  };
}
