{ ... }:
{
  home.file.".zshrc" = {
    force = true;
    text = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      if [ -f "$HOME/.profile" ]; then
        source "$HOME/.profile"
      fi

      # If it is an interactive shell and fish exists, launch fish automatically.
      if [[ -o interactive ]] && command -v fish &> /dev/null && [[ -z "$FISH_VERSION" ]]; then
        exec fish
      fi
    '';
  };
}
