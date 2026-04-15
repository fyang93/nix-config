{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (mpv.override {
      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
        eisa01.simplehistory
      ];
    })
  ];
}
