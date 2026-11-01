{ pkgs, ... }:
{
  imports = [
    # ../custom
    ./terminal
    ./fcitx5
    ./xdg.nix
    ./obs.nix
    ./mpv.nix
  ];

  home.packages = with pkgs; [
    # wayland
    wl-clipboard

    # browser
    firefox
    nautilus

    # work
    wechat
    feishu
    #(callPackage ./lark.nix { })
    remmina

    # cloud storage
    # onedrivegui
  ];
}
