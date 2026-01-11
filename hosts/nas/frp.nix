{
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      serverAddr = "10.10.10.10";
      serverPort = 123;
      auth.method = "token";
      auth.token = "nozoeli1314"; 
      proxies = [
        {
          name = "ssh";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 8080;
          remotePort = 50009;
        }
      ];
    };
  };
}
