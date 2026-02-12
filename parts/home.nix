{ inputs, secrets, ... }:
{
  flake.homeConfigurations = {
    "yang@wsl" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
        inherit secrets;
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
        inherit secrets;
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
        inherit secrets;
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
        inherit secrets;
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
        inherit secrets;
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/desktop
      ];
    };
  };
}
