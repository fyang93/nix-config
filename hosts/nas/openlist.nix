{ pkgs, secrets, ... }:
{
  environment.systemPackages = with pkgs; [
    openlist
  ];

  users.users.openlist = {
    isSystemUser = true;
    group = "openlist";
    extraGroups = [ "storage" ];
  };

  users.groups.openlist = {};

  systemd.services.openlist = {
    description = "OpenList";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      User = "openlist";
      Group = "openlist";

      StateDirectory = "openlist";
      WorkingDirectory = "/var/lib/openlist";

      ExecStart = "${pkgs.openlist}/bin/OpenList server";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  networking.firewall.allowedTCPPorts = [ 5244 ];
}
