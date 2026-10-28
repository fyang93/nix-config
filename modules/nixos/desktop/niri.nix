{ pkgs, ... }:
{
  programs.niri.enable = true;

  environment.systemPackages = [ pkgs.xwayland-satellite ];

  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --user yang --cmd ${pkgs.niri}/bin/niri-session";
  };
}
