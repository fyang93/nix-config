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

  # Wayland 下由 NixOS 的 waylandFrontend 处理输入法环境，避免全局强制 Qt/GTK 输入法模块干扰 Plasma 锁屏。
  # home.sessionVariables = {
  #   XMODIFIERS = "@im=fcitx";
  #   GTK_IM_MODULE = "fcitx";
  #   QT_IM_MODULE = "fcitx";
  # };

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

  home.file.".local/share/fcitx5/themes/mellow-wechat-dark" = {
    source = ./mellow-wechat-dark;
    recursive = true;
    force = true;
  };
}
