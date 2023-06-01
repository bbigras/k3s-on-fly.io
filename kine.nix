{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kine";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "k3s-io";
    repo = "kine";
    rev = "v${version}";
    sha256 = "sha256-HU3yCdNHAPTY4uh1UXLF0Hk3gGC7zIF0wqnsmzOP+Kk=";
  };

  vendorSha256 = "sha256-/TLxfv/1DhrDQGES/7MUz15DGIJ521b+zLIeixqPJZg=";
}
