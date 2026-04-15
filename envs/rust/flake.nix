{
  description = "Rust Dev Env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            # Rust stable + rust-src
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = [
                "rust-src"
                "cargo"
                "rustc"
              ];
            })
          ];

          buildInputs = with pkgs; [
            # runtime dependencies
          ];

          shellHook = ''
            export RUST_SRC_PATH=${
              pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
              }
            }/lib/rustlib/src/rust/library
          '';
        };
      }
    );
}
