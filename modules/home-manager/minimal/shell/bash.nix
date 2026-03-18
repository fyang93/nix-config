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
    bleopt complete_auto_delay=100
    bleopt prompt_eol_mark=' '
    bleopt exec_errexit_mark=
    # bleopt exec_exit_mark=

    # Fish-like abbrs
    ble-sabbrev cd=z
    ble-sabbrev g=git
    ble-sabbrev j=just

    # fzf integration
    ble-import -d integration/fzf-completion
    ble-import -d integration/fzf-key-bindings

    ble-bind -x C-l 'command clear -x'

    # issue: https://github.com/akinomyoga/ble.sh/issues/96
    ble/path#remove-glob PATH '/mnt/*'

    # Catppuccin Mocha inspired theme for ble.sh
    # Commands
    ble-face command_alias='fg=#a6e3a1,italic'
    ble-face command_builtin='fg=#a6e3a1,italic'
    ble-face command_builtin_dot='fg=#a6e3a1,italic'
    ble-face command_directory='fg=#89b4fa'
    ble-face command_file='fg=#a6e3a1,italic'
    ble-face command_function='fg=#a6e3a1,italic'
    ble-face command_jobs='fg=#a6e3a1'
    ble-face command_keyword='fg=#a6e3a1,italic'

    # Arguments
    ble-face argument_error='fg=#eba0ac'
    ble-face argument_option='fg=#fab387'

    # Auto complete
    ble-face auto_complete='fg=#9399b2,italic'

    # Cmdinfo
    ble-face cmdinfo_cd_cdpath='fg=#89b4fa'

    # Disabled
    ble-face disabled='fg=#585b70'

    # Filenames
    ble-face filename_block='fg=#f9e2af'
    ble-face filename_character='fg=#f9e2af'
    ble-face filename_directory='fg=#89b4fa,underline'
    ble-face filename_directory_sticky='fg=#89b4fa,underline,bold'
    ble-face filename_executable='fg=#a6e3a1,bold'
    ble-face filename_link='fg=#89dceb'
    ble-face filename_ls_colors='ref:filename_other'
    ble-face filename_orphan='fg=#f38ba8'
    ble-face filename_other='fg=#cdd6f4'
    ble-face filename_pipe='fg=#f9e2af'
    ble-face filename_setgid='fg=#f9e2af'
    ble-face filename_setuid='fg=#f9e2af'
    ble-face filename_socket='fg=#cba6f7'
    ble-face filename_url='fg=#89b4fa,underline'
    ble-face filename_warning='fg=#f38ba8'

    # Menu filter
    # ble-face menu_filter_fixed='fg=#cdd6f4'
    # ble-face menu_filter_input='fg=#a6e3a1'

    # Misc
    ble-face overwrite_mode='fg=#f38ba8'
    ble-face prompt_status_line='fg=#cdd6f4'

    # Region
    ble-face region='bg=#45475a'
    ble-face region_insert='bg=#313244'
    ble-face region_match='bg=#45475a,fg=#a6e3a1'
    ble-face region_target='bg=#45475a'

    # Syntax
    ble-face syntax_brace='fg=#cdd6f4'
    ble-face syntax_command='fg=#b4befe'
    ble-face syntax_comment='fg=#585b70,italic'
    ble-face syntax_default='fg=#cdd6f4'
    ble-face syntax_delimiter='fg=#f38ba8'
    ble-face syntax_document='fg=#f9e2af'
    ble-face syntax_document_begin='fg=#f9e2af'
    ble-face syntax_error='fg=#eba0ac'
    ble-face syntax_escape='fg=#f38ba8'
    ble-face syntax_expr='fg=#cdd6f4'
    ble-face syntax_function_name='fg=#a6e3a1'
    ble-face syntax_glob='fg=#cdd6f4'
    ble-face syntax_history_expansion='fg=#cba6f7,italic'
    ble-face syntax_param_expansion='fg=#f38ba8'
    ble-face syntax_quotation='fg=#f9e2af'
    ble-face syntax_quoted='fg=#f9e2af'
    ble-face syntax_tilde='fg=#fab387,italic'
    ble-face syntax_varname='fg=#f5e0dc'

    # Varnames
    ble-face varname_array='fg=#cdd6f4'
    ble-face varname_empty='fg=#cdd6f4'
    ble-face varname_export='fg=#89dceb'
    ble-face varname_expr='fg=#cdd6f4'
    ble-face varname_hash='fg=#cdd6f4'
    ble-face varname_number='fg=#fab387'
    ble-face varname_readonly='fg=#f38ba8'
    ble-face varname_transform='fg=#cdd6f4'
    ble-face varname_unset='fg=#f38ba8'

    # Vbell
    ble-face vbell='fg=#cdd6f4,reverse'
    ble-face vbell_erase='fg=#cdd6f4'
    ble-face vbell_flash='fg=#a6e3a1,reverse'
  '';

  # explorer for wsl
  home.file.".local/bin/explorer" = {
    text = ''
      #!/usr/bin/env bash
      exec /mnt/c/Windows/explorer.exe "$@"
    '';
    executable = true;
  };

  # vscode for wsl
  home.file.".local/bin/code" = {
    text = ''
      #!/usr/bin/env bash
      exec "/mnt/c/Users/fyang/AppData/Local/Programs/Microsoft VS Code/Code.exe" "$@"
    '';
    executable = true;
  };
}
