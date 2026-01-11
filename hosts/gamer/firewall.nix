{
  networking = {
    firewall = {
      enable = true;
      # 9050 for duckov
      allowedTCPPorts = [ 9050 ];
      allowedUDPPorts = [ 9050 ];
    };
    nftables.enable = true;
  };
}