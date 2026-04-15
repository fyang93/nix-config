{ username, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  wsl = {
    enable = true;
    wrapBinSh = false; # https://github.com/microsoft/vscode-remote-release/issues/10375
    useWindowsDriver = true; # required by nvidia-container-toolkit-cdi-generator
    defaultUser = "${username}";
  };

  networking.hostName = "wsl"; # Define your hostname.

  environment.sessionVariables = {
    LD_LIBRARY_PATH = [
      "/usr/lib/wsl/lib"
    ];
  };

  # Set your time zone.
  # time.timeZone = "Asia/Shanghai";
  services.automatic-timezoned.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user session.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
