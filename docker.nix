{ pkgs }:

with pkgs;

let
  kine = callPackage ./kine.nix { };

  my_k3s = (k3s.override { iptables = iptables-legacy; });

  procFile = writeTextFile {
    name = "Procfile";
    text = ''
      k3s: ${my_k3s}/bin/k3s server --token=my_token --datastore-endpoint=http://127.0.0.1:2379 --node-taint CriticalAddonsOnly=true:NoExecute --node-name=node1 --snapshotter=native --flannel-backend=wireguard-native
      kine: ${kine}/bin/kine --endpoint "nats://127.0.0.1"
      nats: ${nats-server}/bin/nats-server --jetstream --store_dir /var/lib/nats
    '';
  };
in
dockerTools.streamLayeredImage {
  name = "k3s";
  tag = "latest";

  contents = [
    dockerTools.binSh
    dockerTools.caCertificates
    dockerTools.usrBinEnv
    coreutils
    fakeNss
  ];

  config = {
    Env = [ "PATH=/bin:/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin" ];
    Cmd = [
      "${overmind}/bin/overmind"
      "start"
      "--procfile"
      "${procFile}"
      "-r"
      "kine"
    ];
  };
}
