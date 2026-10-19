{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

    package = pkgs.steam.override {
      # https://github.com/NixOS/nixpkgs/issues/279893
      extraProfile = ''
        unset TZ
        export GDK_SCALE=1
        export GDK_DPI_SCALE=1.2
        # Let the desktop supply the cursor size, including Xwayland scaling.
        # Expose the cursor theme inside Steam's container.
        export XCURSOR_THEME=breeze_cursors
        export XCURSOR_PATH="${pkgs.kdePackages.breeze}/share/icons''${XCURSOR_PATH:+:$XCURSOR_PATH}"
      '';
    };
  };

  programs.gamemode.enable = true;

  # Duckov: 9050
  networking.firewall.allowedTCPPorts = [ 9050 ];
  networking.firewall.allowedUDPPorts = [ 9050 ];
}
