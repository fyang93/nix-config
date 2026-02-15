{ config, pkgs, ... }:
{
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

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
          "HarmonyOS Sans"
          #"LXGW Neo XiHei"
        ];
        monospace = [
          "Maple Mono"
          "HarmonyOS Sans"
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

  ###################################################################################
  #
  #  Copy from https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279
  #  Mainly for flatpak
  #    1. bindfs resolves all symlink,
  #    2. allowing all fonts to be accessed at `/usr/share/fonts`
  #    3. without letting /nix into the sandbox.
  #
  ###################################################################################

  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "resolve-symlinks"
          "x-gvfs-hide"
        ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };
}
