{ pkgs, ... }:
{
  home.packages = with pkgs; [
    krabby
  ];

  programs = {
    fish = {
      enable = true;
      shellAbbrs = {
        cd = "z";
      };
      shellAliases = {
        "ls" = "eza";
        "l" = "eza -lah --icons=auto";
      };
      shellInit = ''
        zoxide init fish | source
        set -gx EDITOR=vim
        set -gx BUN_INSTALL "$HOME/.bun"
        fish_add_path "$HOME/.local/bin"
        fish_add_path $BUN_INSTALL
        set -g fish_color_command = blue --italics
        set -g fish_color_quote = yellow --italics
        # only print pokemons on interactive shells
        if status --is-interactive
          set -gx LANGUAGE en
          command -q krabby && krabby random 1-3 | tail -n +2
        end
      '';
      functions = {
        fish_greeting = "";
        fish_user_key_bindings = ''
          bind \eh backward-word
          bind \ej down-line-or-history
          bind \ek up-line-or-history
          bind \el forward-word
        '';
      };
      plugins = with pkgs.fishPlugins; [
        # Auto-complete matching pairs
        {
          name = "autopair";
          src = autopair.src;
        }
        # Notifications when long commands finish
        {
          name = "done";
          src = done.src;
        }
      ];
    };
  };
}
