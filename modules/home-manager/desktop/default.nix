{ pkgs, ... }:
{
  imports = [
    # ../custom
    # ./niri
    ./terminal
    ./fcitx5
    ./xdg.nix
    # ./zed.nix
    ./vscode.nix
    ./obs.nix
    ./mpv.nix
    ./stylix.nix
  ];

  home.packages = with pkgs; [
    # browser
    firefox

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
