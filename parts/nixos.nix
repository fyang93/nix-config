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
        ../hosts/nas
        ../modules/nixos/common/graphics.nix
        ../modules/nixos/common/networkmanager
        ../modules/nixos/minimal
        ../modules/nixos/desktop
        ../modules/nixos/users/yang.nix
        ../modules/nixos/users/guest.nix
      ];
    };
    gamer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        username = "yang";
        inherit secrets;
      };
      modules = [
        ../hosts/gamer
        ../modules/nixos/common/graphics.nix
        ../modules/nixos/common/nvidia.nix
        ../modules/nixos/common/bluetooth.nix
        ../modules/nixos/common/networkmanager
        ../modules/nixos/common/virtualisation
        ../modules/nixos/minimal
        ../modules/nixos/desktop
        ../modules/nixos/desktop/gaming.nix
        ../modules/nixos/users/yang.nix
        ../modules/nixos/users/guest.nix
      ];
    };
  };
}
