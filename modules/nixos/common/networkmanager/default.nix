{
  networking.networkmanager.dns = "none";

  networking.nameservers = [
    "1.1.1.1"
    "2606:4700:4700::1111"
    "8.8.8.8"
    "2001:4860:4860::8888"
  ];
}