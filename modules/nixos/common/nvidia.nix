{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false; # closed-source module kernel
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"]; # will install nvidia-vaapi-driver by default
}
