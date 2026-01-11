{
  description = "Node.js Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake {
      inherit inputs;

      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nodejs_20
              nodePackages.pnpm
            ];

            shellHook = ''
              echo "Node.js version: $(node --version)"
              echo "pnpm version: $(pnpm --version)"
            '';
          };
        };
    };
}
