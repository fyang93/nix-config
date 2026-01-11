{ pkgs, username, ... }:
{
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.dankMaterialShell = {
    enable = true;

    greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${username}";
    };

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
    };

    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableClipboard = true; # Clipboard history manager
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
  };
  
  
  environment.systemPackages = with pkgs; [
    qt6.qtmultimedia # for system audio
    xwayland-satellite # for wechat error 'elf_dynamic_array_reader.h(64)] tag not found'
  ];
}
