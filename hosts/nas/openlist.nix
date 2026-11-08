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
      Environment = [
        "OPENLIST_TASKS_DOWNLOAD_MAX_RETRY=99"
        "OPENLIST_TASKS_TRANSFER_MAX_RETRY=99"
        "OPENLIST_TASKS_UPLOAD_MAX_RETRY=99"
        "OPENLIST_TASKS_COPY_MAX_RETRY=99"
        "OPENLIST_TASKS_MOVE_MAX_RETRY=99"
        "OPENLIST_TASKS_DECOMPRESS_MAX_RETRY=99"
        "OPENLIST_TASKS_DECOMPRESS_UPLOAD_MAX_RETRY=99"
      ];
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  networking.firewall.allowedTCPPorts = [ 5244 ];
}
