{ pkgs, ... }:
{
  programs.niri.enable = true;

  # Apps like WeChat ask xdpw to remember the chosen output, after which every
  # capture silently reuses it and the chooser below never runs again. Ignore
  # restore data so the chooser decides every time.
  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace src/screencast/screencast.c \
            --replace-fail 'restore_data.version > 0 ? &restore_data : NULL' 'NULL'
        '';
      });
    })
  ];

  # niri's own ScreenCast (via the gnome portal) only offers DMA-BUF, which SHM-only
  # clients like WeChat can't negotiate ("no more input formats"). xdpw captures via
  # wlr-screencopy and offers SHM too, so route ScreenCast through it.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    wlr = {
      enable = true;
      # A single output is captured directly; with multiple outputs, pick one via slurp.
      settings.screencast = {
        chooser_type = "simple";
        chooser_cmd = toString (
          pkgs.writeShellScript "xdpw-chooser" ''
            niri=${pkgs.niri}/bin/niri
            jq=${pkgs.jq}/bin/jq
            if [ "$($niri msg -j outputs | $jq 'length')" -le 1 ]; then
              $niri msg -j focused-output | $jq -r .name
            else
              ${pkgs.slurp}/bin/slurp -f %o -or
            fi
          ''
        );
      };
    };
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Access" = [ "gtk" ];
      "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
    };
  };

  environment.systemPackages = [ pkgs.xwayland-satellite ];

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --user yang --cmd ${pkgs.niri}/bin/niri-session";
  };
}
