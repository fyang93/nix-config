{
  description = "Rust Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake {
      inherit inputs;

      perSystem =
        { system, ... }:
        let
          overlays = [ (import inputs.rust-overlay) ];
          pkgs = import inputs.nixpkgs {
            inherit system overlays;
          };

          rustToolchain = pkgs.rust-bin.stable.latest.default.override {
            extensions = [
              "rust-src"
              "rust-analyzer"
              "cargo"
              "rustc"
            ];
          };
        in
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [
              rustToolchain
            ];

            buildInputs = with pkgs; [
              # extra packages here
            ];

            shellHook = ''
              export RUST_SRC_PATH=${rustToolchain}/lib/rustlib/src/rust/library
            '';
          };
        };
    };
}
