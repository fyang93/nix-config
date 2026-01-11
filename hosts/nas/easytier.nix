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
      ExecStart = "${pkgs.easytier}/bin/easytier-core -i 10.10.10.10 --network-name ${secrets.easytier.network-name} --network-secret ${secrets.easytier.network-secret} -p ${secrets.easytier.server}";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
