{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  xdg.configFile."niri/config.kdl".source = ../niri/config.kdl;

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  imports = [
    # ../custom
    ./terminal
    ./fcitx5
    ./xdg.nix
    ./vscode.nix
    ./obs.nix
    ./mpv.nix
  ];

  home.packages = with pkgs; [
    # wayland
    wl-clipboard

    # browser
    firefox

    # im
    telegram-desktop
    discord
    slack
    wechat

    # work
    wpsoffice-cn
    wemeet
    feishu
    (callPackage ./lark.nix { })
    remmina

    # cloud storage
    # onedrivegui
  ];
}
