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
    firefox

    # im
    telegram-desktop
    slack
    wechat

    # work
    wpsoffice-cn
    wemeet
    feishu
    (callPackage ./lark.nix { })

    # cloud storage
    # onedrivegui
  ];
}
