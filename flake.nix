{
  description = "OpenTechLab C++ Application Example";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
        pkgs = import nixpkgs { inherit system; };
        pkgsUnstable = import nixpkgsUnstable { inherit system; };
      in {
        packages = rec {
          default = pkgs.stdenv.mkDerivation {
            name = "otl_nix_test_app";
            src = ./.;

            nativeBuildInputs = with pkgs; [
              cmake
            ];

            buildInputs = with pkgs; [
              boost
              SDL2
            ];
          };

          dockerImage = pkgsUnstable.dockerTools.buildNixShellImage {
            tag = "latest";
            drv = default.overrideAttrs (old: { src = null; });
          };
        };
      });
}
