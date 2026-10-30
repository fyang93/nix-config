{ pkgs, lib, ... }:
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
  # config.kdl includes monitor.kdl, which nwg-displays owns; make sure it exists.
  home.activation.niriMonitorKdl = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.config/niri"
    [ -e "$HOME/.config/niri/monitor.kdl" ] || run touch "$HOME/.config/niri/monitor.kdl"
  '';

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
    nwg-displays

    # browser
    firefox
    nautilus

    # work
    #(callPackage ./lark.nix { })
    remmina

    # cloud storage
    # onedrivegui
  ];
}
