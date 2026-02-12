{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      cd = "z";
      g = "git";
      j = "just";
    };
    shellAliases = {
      l = "eza -lah --icons=auto";
      lt = "eza --tree --level=2 --icons=auto";
      cat = "bat -p --paging=never";
      opencode = "bun $(which opencode)";
      codex = "bun $(which codex)";
    };
    shellInit = ''
      zoxide init fish | source
      set -g fish_color_command = blue --italics
      set -g fish_color_quote = yellow --italics
      # only print pokemons on interactive shells
      if status --is-interactive
        set -gx LANGUAGE en
        command -q krabby && krabby random 1-3 | tail -n +2
      end
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "done";
        src = done.src;
      }
    ];
    functions = {
      fish_greeting = "";
      fish_config = "";
    };
  };
}
