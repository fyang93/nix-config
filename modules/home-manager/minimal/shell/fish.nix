{ pkgs, lib, secrets, ... }:
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
    shellInitLast = lib.concatStringsSep "\n" (
      lib.mapAttrsToList (k: v: "set -gx ${k} ${lib.escapeShellArg v}") secrets.env
    );
    interactiveShellInit = ''
      set -gx LANGUAGE en
      zoxide init fish | source
      set -g fish_features no-expand-full qmark-noglob stderr-nocaret
      fish_config theme choose "catppuccin-mocha"
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
        # set italics
        for var in fish_color_command fish_color_quote
          contains -- --italics $$var; or set -g $var $$var --italics
        end
      '';
    };
  };
}
