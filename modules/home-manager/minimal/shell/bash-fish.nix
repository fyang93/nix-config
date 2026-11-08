{ ... }:
{
  home.file.".bashrc".force = true;
  home.file.".profile".force = true;
  home.file.".bash_profile".force = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      # if it is interactive shell and fish exists, auto launch fish
      if [[ $- == *i* ]] && command -v fish &> /dev/null && [[ -z "$FISH_VERSION" ]]; then
        exec fish
      fi
    '';
  };
}
