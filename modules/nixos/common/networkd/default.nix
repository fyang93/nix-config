{
  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
  };

  services.resolved = {
    enable = true;
    fallbackDns = [
      "1.1.1.1"
      "2606:4700:4700::1111"
      "8.8.8.8"
      "2001:4860:4860::8888"
    ];
  };

  systemd.network = {
    enable = true;
    wait-online.enable = false;
    networks = {
      "10-physical" = {
        matchConfig = {
          Type = "ether wlan !loopback !bridge !none";
          Name = "!vnet*";
        };
        DHCP = "yes";
        networkConfig.KeepConfiguration = "dynamic";
        dhcpV4Config.RouteMetric = 2048;
        dhcpV6Config.RouteMetric = 2048;
      };
    };
  };
}