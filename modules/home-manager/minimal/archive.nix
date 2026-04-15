{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # archive
    ouch
    zip
    xz
    unzip
    p7zip
    zstd
    gnutar
  ];
}
