{ pkgs, pre-commit-hooks, system }:

with pkgs;

let
  pre-commit-check = pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      deadnix.enable = true;
      nixpkgs-fmt.enable = true;
      statix.enable = true;
    };
    excludes = [ ];
  };
in
mkShell {
  buildInputs = [
    flyctl
    skopeo
  ];

  shellHook = ''
    ${pre-commit-check.shellHook}
  '';
}
