{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };
    fonts = {
      monospace.name = "Maple Mono";
      monospace.package = pkgs.maple-mono.variable;
      sansSerif.name = "LXGW NeoXiHei";
      sansSerif.package = pkgs.lxgw-neoxihei;
      serif.name = "LXGW NeoXiHei";
      serif.package = pkgs.lxgw-neoxihei;
      emoji.name = "Noto Color Emoji";
      emoji.package = pkgs.noto-fonts-color-emoji;
    };
    fonts.sizes = {
      terminal = 12;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };
}
