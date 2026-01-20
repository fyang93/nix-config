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
        "opencode" = "bun $(which opencode)";
      };
      shellInit = ''
        zoxide init fish | source
        export EDITOR=vim
        export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
        set -g fish_color_command = blue --italics
        set -g fish_color_quote = yellow --italics
        # only print pokemons on interactive shells
        if status --is-interactive
          set -gx LANG en_US.UTF-8
          set -gx LC_ALL en_US.UTF-8
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
