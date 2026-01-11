{ ... }:
{
  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader.timeout = 0; # 默认5s太长了
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"        
    ];
    plymouth.enable = true;
  };
}