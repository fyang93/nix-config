{
  programs.foot = {
    enable = true;
    # https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
    settings = {
      main = {
        term = "xterm-256color";
        # font = "monospace:size=12";
        # dpi-aware = "yes";
        pad = "20x15 center-when-maximized-and-fullscreen";
        initial-window-size-chars="100x25";
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}