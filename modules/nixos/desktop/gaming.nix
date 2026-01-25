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
      '';
    };
  };

  programs.gamemode.enable = true;

  # Duckov: 9050
  networking.firewall.allowedTCPPorts = [ 9050 ];
  networking.firewall.allowedUDPPorts = [ 9050 ];
}
