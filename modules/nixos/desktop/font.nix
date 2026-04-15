{ config, pkgs, ... }:
{
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    packages = with pkgs; [
      # icons
      noto-fonts-color-emoji
      material-icons
      material-design-icons
      font-awesome
      nerd-fonts.symbols-only

      # core
      maple-mono.variable
      # lxgw-neoxihei

      # extra
      noto-fonts

      # 添加自定义字体
      (stdenvNoCC.mkDerivation {
        name = "my-custom-fonts";
        src = ./fonts; # 使用绝对路径

        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          find $src -type f \( -iname "*.ttf" -o -iname "*.otf" \) -exec cp {} $out/share/fonts/truetype/ \;
        '';
      })
    ];

    fontconfig = {
      # User defined default fonts
      # https://catcat.cc/post/2021-03-07/
      defaultFonts = {
        serif = [
          "TsangerJinKai03"
        ];
        sansSerif = [
          "HarmonyOS Sans SC"
          #"LXGW Neo XiHei"
        ];
        monospace = [
          "Maple Mono"
          "HarmonyOS Sans SC"
          #"LXGW Neo XiHei"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
      antialias = true; # 抗锯齿
      hinting.enable = false; # 禁止字体微调 - 高分辨率下没这必要
      subpixel = {
        rgba = "rgb"; # IPS 屏幕使用 rgb 排列
      };
    };
  };
}
