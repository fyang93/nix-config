{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableBashIntegration = true;
    settings = {
      window_padding_width = "5 10 5 10";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      bold_font = "family='Maple Mono' style=Bold";
      initial_window_width  = "200c";
      initial_window_height = "50c";
      tab_bar_edge = "top";
    };
  };
}
