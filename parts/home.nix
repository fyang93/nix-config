{ inputs, secrets, ... }:
{
  flake.homeConfigurations = {
    "yang@wsl" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
      ];
    };
    "yang@home" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/desktop
        inputs.noctalia.homeModules.default
      ];
    };
    "yang@nas" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/desktop
        inputs.noctalia.homeModules.default
      ];
    };
    "guest@nas" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "guest";
        useremail = "guest@mail.com";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
      ];
    };
  };
}
