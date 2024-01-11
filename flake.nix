{
  description = "Julius Hypedrive project";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/master";
  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.grafbase.url = "github:grafbase/grafbase";

  outputs = inputs @ {
    self,
    flake-parts,
    devshell,
    nixpkgs,
    grafbase,
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        devshell.flakeModule
      ];

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "i686-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        system,
        inputs',
        ...
      }: {
        devshells.default = {
          commands = [
            {
              package = grafbase.packages."${system}".cli;
              category = "development";
            }
            {
              package = pkgs.rustup;
              category = "development";
            }
            {
              package = pkgs.gcc;
              category = "development";
            }
            {
              package = pkgs.wasm-pack;
              category = "development";
            }
            {
              package = pkgs.nodejs;
              category = "development";
            }
            {
              package = pkgs.nodePackages.npm;
              category = "development";
            }
          ];
        };
      };
    };
}
