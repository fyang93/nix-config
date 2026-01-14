{ secrets, ... }:
{
  services.frp = {
    enable = true;
    role = "client";
    settings = {
      serverAddr = "${secrets.frp.server}";
      serverPort = secrets.frp.port;
      auth.method = "token";
      auth.token = "${secrets.frp.token}"; 
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
