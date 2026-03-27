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
      l = "eza -lah";
      lt = "eza --tree --level=2";
      cat = "bat --style=plain --paging=never";
      opencode = "bunx opencode";
    };
    interactiveShellInit = ''
      zoxide init fish | source
      set -g fish_features no-expand-full qmark-noglob stderr-nocaret
      set -ga fish_color_command --italics
      set -ga fish_color_quote --italics

      set -gx LANGUAGE en
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
      fish_greeting = ''
        # print pokemons
        command -q krabby && krabby random 1-3 | tail -n +2
      '';
      fish_config = "";
    };
  };
}
