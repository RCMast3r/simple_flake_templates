{
  description = "Example flake using flake-parts and a local overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { system, ... }:
        let
          overlay = import ./overlay.nix;

          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
        in
        {
          _module.args.pkgs = pkgs;

          packages.default = pkgs.hello;
          devShells.default = pkgs.callPackage ./template_lib/devshell.nix {};
        };

      flake = {
        legacyPackages = builtins.genAttrs
          [ "x86_64-linux" "aarch64-linux" ]
          (system:
            import nixpkgs {
              inherit system;
              overlays = [ (import ./overlay.nix) ];
            }
          );
      };
    };
}