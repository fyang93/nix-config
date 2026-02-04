{ inputs, ... }:
{
  flake.homeConfigurations = {
    "yang@wsl" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
      };
      modules = [
        ../modules/home-manager/minimal
      ];
    };
    "yang@gamer" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
      };
      modules = [
        inputs.stylix.homeModules.stylix
        ../modules/home-manager/minimal
        ../modules/home-manager/desktop
      ];
    };
    "yang@nas" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
      };
      modules = [
        inputs.stylix.homeModules.stylix
        ../modules/home-manager/minimal
        ../modules/home-manager/desktop
      ];
    };
    "guest@nas" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "guest";
        useremail = "guest@mail.com";
      };
      modules = [
        ../modules/home-manager/minimal
      ];
    };
    "david@nas" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "david";
        useremail = "david@mail.com";
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/desktop
      ];
    };
  };
}
