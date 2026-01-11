{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        # startup window size
        dimensions = {
          columns = 100;
          lines = 30;
        };
        padding = {
          x = 20;
          y = 10;
        };
        dynamic_padding = false;
      };
      font.size = 12;
      selection.save_to_clipboard = true;
    };
  };
}
