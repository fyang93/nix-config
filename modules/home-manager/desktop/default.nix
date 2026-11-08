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
    google-chrome

    # work
    wechat
    feishu
    #(callPackage ./lark.nix { })
    #wpsoffice-cn
    remmina
  ];
}
