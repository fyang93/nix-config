{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;          # 当前会话内存中保存的历史条数
      save = 100000;         # 写入 ~/.zsh_history 文件的历史条数
      ignoreAllDups = true;
      share = true;          # 多终端共享历史
      extended = true;       # 保存时间戳
      path = "$HOME/.zsh_history";
      ignorePatterns = ["rm *" "pkill *" "cp *"];
    };

    setOptions = [
      "INTERACTIVE_COMMENTS" # 允许交互模式中的注释
      "AUTO_CD"              # 输入目录名直接跳转
      "GLOB_DOTS"            # 让 * 匹配隐藏文件
      "EXTENDED_GLOB"        # 更强大的通配符
      "NO_BEEP"              # 关闭烦人的提示音
    ];

    shellAliases = {
      ls = "eza";
      l = "eza -lah --icons=auto";
      lt = "eza --tree --level=2 --icons=auto";  # 树状视图
      opencode = "bun $(which opencode)";
      codex = "bun $(which codex)";
      cat = "bat -p --paging=never";

      # 安全操作
      cp = "cp -i";   # 覆盖前确认
      mv = "mv -i";   # 覆盖前确认
      rm = "rm -i";   # 删除前确认
    };

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        # compdump location
        export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
        mkdir -p ~/.cache/zsh
      '')
      
      (lib.mkOrder 1000 ''
        export FZF_CTRL_R_OPTS="--layout=reverse --border --height=40%"
        
        # fzf-tab 配置
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
        zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border

        # 智能补全
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
        
        # SSH 补全 - 从 ~/.ssh/config 提取所有 Host（排除通配符）
        if [[ -f ~/.ssh/config ]]; then
          ssh_hosts=($(awk '/^Host / && !/\*/ {for(i=2;i<=NF;i++) print $i}' ~/.ssh/config))
          zstyle ':completion:*:(ssh|scp|sftp):*' hosts $ssh_hosts
        fi

        if [[ -o interactive ]]; then
          export LANGUAGE=en
          command -v krabby >/dev/null && krabby random 1-3 | tail -n +2
        fi
      '')
    ];

    zsh-abbr = {
      enable = true;
      abbreviations = {
        cd = "z";
      };
    };

    plugins = [
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-notify";
        src = pkgs.fetchFromGitHub {
          owner = "marzocchi";
          repo = "zsh-notify";
          rev = "master";
          sha256 = "sha256-ovmnl+V1B7J/yav0ep4qVqlZOD3Ex8sfrkC92dXPLFI=";
        };
        file = "notify.plugin.zsh";
      }
    ];
  };
}
