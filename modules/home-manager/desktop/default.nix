{ pkgs, ... }:
{
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
    google-chrome

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
