{ pkgs, ... }:
{
  security.sudo.enable = false;

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
        keepEnv = true;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    doas-sudo-shim
  ];
}