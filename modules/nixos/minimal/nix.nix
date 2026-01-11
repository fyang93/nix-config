{ lib, ... }:
{
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 30d";
  };

  nix.settings = {
    # Manual optimise storage: nix-store --optimise
    # https://nix.dev/manual/nix/2.28/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.
}
