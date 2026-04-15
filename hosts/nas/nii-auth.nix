{ secrets, ... }:
{
  networking.networkmanager = {
    enable = true;
    logLevel = "INFO";
    ensureProfiles = {
      profiles = {
        "nii-auth" = {
          connection = {
            id = "nii-auth";
            type = "ethernet";
            autoconnect = true;
          };
          "802-1x" = {
            eap = "peap";
            identity = secrets.nii-auth.identity;
            password = secrets.nii-auth.password;
            ca-cert = "${./jimucasha2.cer}";
          };
          ipv4.method = "auto"; # DHCP
          ipv6.method = "auto";
        };
      };
    };
  };
}
