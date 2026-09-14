{ pkgs, secrets, ... }:
{
  environment.systemPackages = with pkgs; [
    easytier
  ];

  systemd.services.easytier = {
    description = "Easytier Core";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.easytier}/bin/easytier-core -i 10.10.10.3 --network-name ${secrets.easytier.network-name} --network-secret ${secrets.easytier.network-secret} -p ${secrets.easytier.server}";
      Restart = "always";
      RestartSec = 5;
    };
  };

  systemd.services.easytier-watchdog = {
    description = "EasyTier Watchdog";
    after = [ "easytier.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "easytier-watchdog" ''
        if ! ping -c 3 -W 5 10.10.10.1 > /dev/null 2>&1; then
          systemctl restart easytier
        fi
      '';
    };
  };

  systemd.timers.easytier-watchdog = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "5min";
    };
  };
}
