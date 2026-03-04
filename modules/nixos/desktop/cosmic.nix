{pkgs, ...}:

{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-term
    cosmic-player
  ];

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  
  environment.systemPackages = with pkgs; [
    polkit_gnome # polkit agent
  ];
}