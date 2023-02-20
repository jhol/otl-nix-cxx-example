{
  description = "OpenTechLab C++ Application Example";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs }: {
    packages."x86_64-linux" = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in {
      default = pkgs.stdenv.mkDerivation {
        name = "otl_nix_test_app";
        src = ./.;

        nativeBuildInputs = [
          pkgs.cmake
        ];

        buildInputs = [
          pkgs.boost
          pkgs.SDL2
        ];
      };
    };
  };
}
