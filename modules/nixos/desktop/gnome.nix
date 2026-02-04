{pkgs, ...}:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  environment.systemPackages = with pkgs; [
    baobab
    gnome-calendar
    gnome-clocks
    gnome-font-viewer
    gnome-logs
    gnome-system-monitor
    gnome-weather
    loupe
    nautilus
    gnome-connections
    snapshot
    file-roller

    # extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.dash-to-panel
    gnomeExtensions.appindicator
  ];
}