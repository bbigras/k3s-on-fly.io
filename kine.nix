{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kine";
  version = "0.9.9";

  src = fetchFromGitHub {
    owner = "k3s-io";
    repo = "kine";
    rev = "v${version}";
    sha256 = "sha256-NzulAVdweg2Gb5v0OXzni3GwX7/xQV+hqk6FfRzZ8K4=";
  };

  vendorSha256 = "sha256-sDAMVy+usn35r4UVRBBzzZo+Ij4OAHUkbNoZgHTVp08=";
}
