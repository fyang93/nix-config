{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      window_padding_width = "10 20 10 20";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      bold_font = "family='Maple Mono NF CN' style=ExtraBold";
    };
  };
}
