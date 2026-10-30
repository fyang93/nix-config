{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-rime
      fcitx5-mozc
    ];
    fcitx5.waylandFrontend = true;
  };

  home.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
  };

  home.file.".config/fcitx5/profile" = {
    source = ./profile;
    force = true;
  };

  home.file.".config/fcitx5/config" = {
    source = ./config;
    force = true;
  };

  home.file.".config/fcitx5/conf/classicui.conf" = {
    source = ./classicui.conf;
    force = true;
  };

  # On niri flatpak apps draw the candidate panel themselves, so share the fcitx5
  # config and themes with every sandbox (flatpak also maps xdg-config/xdg-data
  # subpaths into each app's own ~/.var/app/<id> dirs). /nix/store is needed to
  # resolve the home-manager symlinks. The theme uses PNG images (SVGs kept as
  # sources) since some bundled Qt builds (e.g. WeChat) can't load SVG.
  #
  # TODO: the real fix is text-input-v3 (no GTK_IM_MODULE, QT_IM_MODULES=wayland;fcitx),
  # where fcitx5 draws its own themed panel and no sharing is needed. Not yet
  # usable: Qt < 6.7 (e.g. WeChat's bundled Qt 6.6) has no text-input-v3 on niri.
  xdg.dataFile."flatpak/overrides/global" = {
    text = ''
      [Context]
      filesystems=xdg-config/fcitx5:ro;xdg-data/fcitx5/themes:ro;/nix/store:ro;

      [Environment]
      XMODIFIERS=@im=fcitx
      GTK_IM_MODULE=fcitx
      QT_IM_MODULE=fcitx
    '';
    force = true;
  };

  home.file.".local/share/fcitx5/themes/mellow-wechat-dark" = {
    source = ./mellow-wechat-dark;
    recursive = true;
    force = true;
  };
}
