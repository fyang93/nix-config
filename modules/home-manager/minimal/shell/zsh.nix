{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
 
    history = {
      size = 10000;          # Number of history lines to keep in memory
      save = 100000;         # Number of history lines to save in ~/.zsh_history
      ignoreAllDups = true;
      share = true;          # Share history between multiple terminals
      extended = true;       # Save timestamps
      path = "$HOME/.zsh_history";
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };

    setOptions = [
      "INTERACTIVE_COMMENTS" # Allow comments in interactive mode
      "AUTO_CD"              # Jump to directory by typing its name directly
      "GLOB_DOTS"            # Allow * to match hidden files
      "EXTENDED_GLOB"        # Enable advanced globbing features
      "NO_BEEP"              # Disable annoying beep sounds
    ];

    shellAliases = {
      l = "eza -lah --icons=auto";
      lt = "eza --tree --level=2 --icons=auto";
      cat = "bat --style=plain --paging=never";
      opencode = "bun $(which opencode)";
      codex = "bun $(which codex)";

      # Safety operations
      cp = "cp -i";   # Confirm before overwriting
      mv = "mv -i";   # Confirm before overwriting
      rm = "rm -i";   # Confirm before deleting
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        # compdump location
        export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
        mkdir -p ~/.cache/zsh
      '')
      
      (lib.mkOrder 1500 ''
        # Smart completion
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
        
        # SSH completion - Extract all Hosts from ~/.ssh/config (excluding wildcards)
        if [[ -f ~/.ssh/config ]]; then
          ssh_hosts=($(awk '/^Host / && !/\*/ {for(i=2;i<=NF;i++) print $i}' ~/.ssh/config))
          zstyle ':completion:*:(ssh|scp|sftp):*' hosts $ssh_hosts
        fi

        if [[ $- == *i* ]]; then
          export LANGUAGE=en
          command -v krabby >/dev/null && krabby random 1-3 | tail -n +2
        fi
      '')
    ];

    zsh-abbr = {
      enable = true;
      abbreviations = {
        cd = "z";
        g = "git";
        j = "just";
      };
    };

    plugins = [
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting-catppuccin";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "main";
          hash = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
        };
        file = "themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";  # flavor: latte, frappe, macchiato, mocha
      }
    ];
  };
}