{
  description = "k3s-on-fly.io";
  nixConfig.substituters = [
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://pre-commit-hooks.cachix.org"
    "https://k3s-on-fly.cachix.org"
  ];
  nixConfig.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    "k3s-on-fly.cachix.org-1:mbTxv0x9GYNeLd7DL7R9Lmh+ruU1DOTHdRSz64HbXTg="
  ];

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          devShell = import ./shell.nix { inherit pkgs pre-commit-hooks system; };
          packages.dockerImage = import ./docker.nix {
            inherit pkgs;
            inherit (self) lastModifiedDate;
          };
        }
      );
}
