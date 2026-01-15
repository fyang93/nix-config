{ pkgs, lib, ... }:

let
  # 直接沿用原版 feishu 的依赖定义列表
  rpath = lib.makeLibraryPath (with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    glibc
    gnutls
    libGL
    libx11
    libxscrnsaver
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxtst
    libappindicator-gtk3
    libcxx
    libdbusmenu
    libdrm
    libgcrypt
    libglvnd
    libnotify
    libpulseaudio
    libuuid
    libxcb
    libxkbcommon
    libxkbfile
    libxshmfence
    libgbm
    nspr
    nss
    pango
    pciutils
    pipewire
    pixman
    stdenv.cc.cc
    systemd
    wayland
    xdg-utils
  ]);
in
(pkgs.feishu.override { }).overrideAttrs (oldAttrs: rec {
  pname = "lark";
  version = "7.54.11";

  # https://www.larksuite.com/api/downloads
  src = pkgs.fetchurl {
    url = "https://sf16-sg.larksuitecdn.com/obj/lark-artifact-storage/16f3e68c/Lark-linux_x64-7.54.11.deb";
    sha256 = "sha256-qrQC5rMMJc9Obp1QXkQxpPkC29vktKbSoUPVmZQqAdk=";
  };

  installPhase = ''
    runHook preInstall

    # 解压缩并处理目录
    dpkg --fsys-tarfile $src | tar --extract
    mkdir -p $out
    mv usr/share $out/
    mv opt/ $out/

    # 定义 Lark 的主路径 (Lark 使用 opt/bytedance/lark)
    local APP_PATH="$out/opt/bytedance/lark"

    # 替换桌面文件中的执行路径
    if [ -f "$out/share/applications/bytedance-lark.desktop" ]; then
      substituteInPlace $out/share/applications/bytedance-lark.desktop \
        --replace /usr/bin/bytedance-lark-stable $out/bin/bytedance-lark
    fi

    # 包装二进制文件以注入运行所需的依赖环境
    for executable in $APP_PATH/lark $APP_PATH/vulcan/vulcan; do
      if [ -f "$executable" ]; then
        wrapProgram $executable \
          --prefix XDG_DATA_DIRS : "$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH" \
          --prefix LD_LIBRARY_PATH : "${rpath}:$APP_PATH:${pkgs.addDriverRunpath.driverLink}/share"
      fi
    done

    # 创建二进制文件的软链接
    mkdir -p $out/bin
    ln -sf $APP_PATH/lark $out/bin/bytedance-lark

    # 创建图标的软链接 (Lark 的资源文件名与飞书相同，但路径不同)
    for size in 16 24 32 48 64 128 256; do
      if [ -f "$APP_PATH/product_logo_$size.png" ]; then
        mkdir -p $out/share/icons/hicolor/''${size}x''${size}/apps
        ln -sf $APP_PATH/product_logo_$size.png $out/share/icons/hicolor/''${size}x''${size}/apps/bytedance-lark.png
      fi
    done

    runHook postInstall
  '';

  meta = oldAttrs.meta // {
    description = "Lark - International version of Feishu (All-in-one collaboration suite)";
    homepage = "https://www.larksuite.com/";
    mainProgram = "bytedance-lark";
  };
})