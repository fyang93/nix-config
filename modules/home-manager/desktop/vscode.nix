{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        mkhl.direnv
        eamodio.gitlens
        christian-kohler.path-intellisense
        ms-vscode-remote.remote-ssh
        # ms-vscode-remote.remote-ssh-edit
        tekumara.typos-vscode
        usernamehw.errorlens
        yzhang.dictionary-completion
        tamasfe.even-better-toml
        mechatroner.rainbow-csv
        # markdown
        yzhang.markdown-all-in-one
        davidanson.vscode-markdownlint
        # python
        ms-python.python
        ms-pyright.pyright
        ms-toolsai.jupyter
        charliermarsh.ruff
        # nix
        jnoortheen.nix-ide
        jeff-hykin.better-nix-syntax
        # rust
        rust-lang.rust-analyzer
      ];
      userSettings = {
        editor.wordWrap = "on";
        security.workspace.trust.enabled = false;
        vim.useSystemClipboard = true;
        editor.minimap.showSlider = "always";
        terminal.integrated.sendKeybindingsToShell = true;
      };
    };
  };

  home.packages = with pkgs; [
    ruff
    pyright
    shellcheck
    nil
    nixd
    nixfmt
  ];
}
