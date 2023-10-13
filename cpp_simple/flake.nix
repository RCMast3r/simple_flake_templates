{
  description = "simple c++ oriented flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
    dependent_flake.url = "github:github_username/github_project";
  };
  outputs = { self, nixpkgs, utils, dependent_flake }:
    let
      this_projects_overlay = final: prev: {
        this_project_pkg = final.callPackage ./default.nix { };
      };
      my_overlays = [ dependent_flake.overlays.default this_projects_overlay ]; 
      pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ self.overlays.default ];
      };
    in
    {
      overlays.default = nixpkgs.lib.composeManyExtensions my_overlays;
      
      packages.x86_64-linux =
        rec {
          this_project_pkg = pkgs.this_project_pkg;
          default = this_project_pkg;
        
        devShells.x86_64-linux.default = 
        pkgs.mkShell rec {
            # Update the name to something that suites your project.
            name = "nix-devshell";
            packages = with pkgs; [
              # Development Tools
              gcc-arm-embedded
              cmake
            ];

            # Setting up the environment variables you need during
            # development.
            shellHook = let
              icon = "f121";
            in ''
              export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
            '';
          };
      
    };
}
