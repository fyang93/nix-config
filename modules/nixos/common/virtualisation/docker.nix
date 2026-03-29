{ pkgs, username, ...  }:
{
  virtualisation = {
    # enable docker
    docker = {
      enable = true;
      # start dockerd on boot.
      # This is required for containers which are created with the `--restart=always` flag to work.
      enableOnBoot = true;
      autoPrune.enable = true;
      #daemon.settings = {
      #  registry-mirrors = [
      #    "https://docker.1panel.live"
      #    "https://docker.1ms.run"
      #    "https://docker.m.daocloud.io"
      #  ];
      #};
    };
  };

  users.users.${username}.extraGroups = [ "docker" ];

  hardware.nvidia-container-toolkit.enable = true;
}
