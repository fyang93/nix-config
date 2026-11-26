{ inputs, secrets, ... }:
{
  flake.homeConfigurations = {
    "bytedance" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."aarch64-darwin";
      extraSpecialArgs = {
        username = "bytedance";
        useremail = "shixiaoyuamy@gmail.com";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/minimal/shell/zsh-fish.nix
        {
          home.homeDirectory = "/Users/bytedance";
          programs.git.settings.user.name = "amy";
        }
      ];
    };
    "deck@steamdeck" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "deck";
        useremail = "deck@steamdeck";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/minimal/shell/bash-fish.nix
      ];
    };
    "yang" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs = {
        username = "yang";
        useremail = "norepfy@gmail.com";
        inherit secrets inputs;
      };
      modules = [
        ../modules/home-manager/minimal
        ../modules/home-manager/minimal/shell/bash-fish.nix
      ];
    };
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
        ({ pkgs, ... }: {
          home.packages = with pkgs; [
            wemeet
            feishu
            whatsapp-electron
            (callPackage ../packages/tern { })
          ];
        })
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
