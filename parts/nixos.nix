{ inputs, secrets, ... }:
{
  flake.nixosConfigurations = {
    wsl = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "yang";
      };
      modules = [
        inputs.nixos-wsl.nixosModules.default
        ../hosts/wsl
        ../modules/nixos/minimal
        ../modules/nixos/users/yang.nix
      ];
    };
    nas = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "yang";
	inherit secrets;
      };
      modules = [
        inputs.dankMaterialShell.nixosModules.dankMaterialShell
        inputs.dankMaterialShell.nixosModules.greeter
        ../hosts/nas
        ../modules/nixos/common/networkmanager
        ../modules/nixos/minimal
        ../modules/nixos/desktop
        ../modules/nixos/users/yang.nix
        ../modules/nixos/users/david.nix
        ../modules/nixos/users/guest.nix
      ];
    };
    gamer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "yang";
      };
      modules = [
        inputs.dankMaterialShell.nixosModules.dankMaterialShell
        inputs.dankMaterialShell.nixosModules.greeter
        ../hosts/gamer
        ../modules/nixos/common/nvidia.nix
        ../modules/nixos/common/bluetooth.nix
        ../modules/nixos/common/networkd
        ../modules/nixos/common/networkd/wifi.nix
        ../modules/nixos/minimal
        ../modules/nixos/desktop
        ../modules/nixos/desktop/gaming.nix
        ../modules/nixos/desktop/autologin.nix
        ../modules/nixos/users/yang.nix
      ];
    };
  };
}
