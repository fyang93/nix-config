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
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    # browser
    google-chrome

    # im
    telegram-desktop
    slack
    wechat

    # work
    wemeet
    feishu

    # rdp
    remmina

    # cloud storage
    # onedrivegui
  ];
}
