{
  description = "k3s-on-fly.io";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { nixpkgs, flake-utils, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          devShell = import ./shell.nix { inherit pkgs pre-commit-hooks system; };
          packages.dockerImage = import ./docker.nix { inherit pkgs; };
        }
      );
}
