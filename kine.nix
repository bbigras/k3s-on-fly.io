{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kine";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "k3s-io";
    repo = "kine";
    rev = "v${version}";
    sha256 = "sha256-4Zv1IjyYLGMH6YcY4pgG4gGsj5j7YsP74Pz193Gq4tQ=";
  };

  vendorSha256 = "sha256-/uoSf46Ep3ppkeO9aUuRP/xNsh5GtM9e4ykmBthcuW8=";
}
