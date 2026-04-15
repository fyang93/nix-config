{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # required by ./scripts/bin/extract-audio
    # ffmpeg-full

    # custom scripts
    (pkgs.buildEnv {
      name = "custom-scripts";
      paths = [ ./scripts ];
    })
  ];
}
