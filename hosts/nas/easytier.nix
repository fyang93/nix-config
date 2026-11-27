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
      ExecStart = "${pkgs.easytier}/bin/easytier-core -i 10.10.10.10 --network-name ${secrets.easytier.network-name} --network-secret ${secrets.easytier.network-secret} --latency-first true -p ${secrets.easytier.server}";
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
        state_dir=/run/easytier-watchdog
        mkdir -p "$state_dir"
        failures=0
        if [ -f "$state_dir/network-failures" ]; then
          read -r failures < "$state_dir/network-failures" || failures=0
        fi

        # Force a NetworkManager Internet connectivity check, regardless of interface.
        connectivity=$(LC_ALL=C ${pkgs.networkmanager}/bin/nmcli --wait 15 networking connectivity check 2>/dev/null || true)
        if ! systemctl is-active --quiet NetworkManager.service || [ "$connectivity" != "full" ]; then
          failures=$((failures + 1))
          echo "$failures" > "$state_dir/network-failures"
          echo "Internet connectivity is not full (state: $connectivity; $failures/3)"
          if [ "$failures" -ge 3 ]; then
            echo 0 > "$state_dir/network-failures"
            echo "Restarting NetworkManager after three failed checks"
            systemctl restart NetworkManager.service
          fi
          exit 0
        fi
        echo 0 > "$state_dir/network-failures"

        if ! ${pkgs.iputils}/bin/ping -c 3 -W 5 10.10.10.1; then
          echo "EasyTier peer is unreachable; restarting easytier"
          systemctl restart easytier.service
        fi
      '';
    };
  };

  systemd.timers.easytier-watchdog = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1min";
    };
  };
}
