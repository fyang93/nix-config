{ pkgs, secrets, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    historySize = 10000;
    historyFileSize = 100000;
    historyFile = "$HOME/.bash_history";
    historyControl = [
      "ignoreboth"  # ignorespace + ignoredups
      "erasedups"
    ];
    historyIgnore = [ "ls" "l" "lt" "cd" "pwd" "exit" "clear" "history" ];

    shellAliases = {
      l  = "eza -lah";
      lt = "eza --tree --level=2";
      cat = "bat --style=plain --paging=never";
      opencode = "bunx opencode";
      codex = "bunx codex";
      agent-browser = "bunx agent-browser";
    };

    sessionVariables = secrets.env;

    # Note that these commands will be run even in non-interactive shells
    bashrcExtra = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      if [ -f "$HOME/.profile" ]; then
        source "$HOME/.profile"
      fi
    '';

    # Extra commands that should be run when initializing an interactive shell
    initExtra = ''
      shopt -s cdspell
      shopt -s autocd
      shopt -s histappend
      export HISTTIMEFORMAT="%F %T  "
      __history_sync() {
        builtin history -a   # append new lines
        builtin history -n   # read new lines
      }
      PROMPT_COMMAND="__history_sync''${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

      if [[ -f ${pkgs.blesh}/share/blesh/ble.sh ]]; then
        source -- ${pkgs.blesh}/share/blesh/ble.sh
      fi

      export LANGUAGE=en
      command -v krabby >/dev/null 2>&1 && krabby random 1-3 --no-mega --no-gmax | tail -n +2
    '';
  };

  # ============================================================
  # blesh config (goes into ~/.blerc)
  # ============================================================
  home.file.".blerc".text = ''
    bleopt complete_auto_delay=300
    bleopt prompt_eol_mark=' '
    bleopt exec_errexit_mark=
    # bleopt exec_exit_mark=

    # fzf integration
    ble-import -d integration/fzf-completion
    ble-import -d integration/fzf-key-bindings

    ble-bind -x C-l 'command clear -x'

    # issue: https://github.com/akinomyoga/ble.sh/issues/96
    ble/path#remove-glob PATH '/mnt/*'

    # Catppuccin Mocha inspired theme for ble.sh
    ble-face command_alias='fg=#a6e3a1,italic'
    ble-face command_builtin='fg=#a6e3a1,italic'
    ble-face command_function='fg=#a6e3a1,italic'
    ble-face command_file='fg=#a6e3a1,italic'
    ble-face command_keyword='fg=#a6e3a1,italic'
    ble-face argument_option='fg=#fab387'
    ble-face command_directory='fg=#89b4fa'
    ble-face filename_directory='fg=#89b4fa,underline'
    ble-face filename_executable='fg=#a6e3a1,bold'
    ble-face syntax_comment='fg=#585b70,italic'
    ble-face syntax_quotation='fg=#f9e2af'
    ble-face syntax_varname='fg=#f5e0dc'
    ble-face syntax_param_expansion='fg=#f38ba8'
    ble-face syntax_command='fg=#b4befe'
    ble-face syntax_error='fg=#eba0ac'
    ble-face syntax_delimiter='fg=#f38ba8'
    ble-face syntax_history_expansion='fg=#cba6f7,italic'
    ble-face auto_complete='fg=#9399b2,italic'
    ble-face region='bg=#45475a'

    # Fish-like abbrs
    ble-sabbrev cd=z
    ble-sabbrev g=git
    ble-sabbrev j=just
  '';

  # explorer for wsl
  home.file.".local/bin/explorer" = {
    text = ''
      #!/usr/bin/env bash
      exec /mnt/c/Windows/explorer.exe "$@"
    '';
    executable = true;
  };
}
