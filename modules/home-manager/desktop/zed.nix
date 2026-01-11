{
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    # https://github.com/zed-industries/extensions/tree/main/extensions
    extensions = [
      "nix"
      "toml"
      "rust"
    ];
    # https://zed.dev/docs/configuring-zed
    userSettings = {
      #theme.mode = "system";
      features.copilot = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      auto_update = false;
      minimap.show = "auto";
      hour_format = "hour24";
      vim_mode = true;
      autosave = "on_focus_change";
      soft_wrap = "editor_width";
      tab_size = 2;

      # Show method signatures in the editor, when inside parentheses
      auto_signature_help = true;
      # Configuration for displaying extra text with hints in the editor
      inlay_hints.enabled = true;
    };
  };
}
