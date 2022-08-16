# k3s-on-fly.io (experimental)

- 1 GB RAM minimum at idle
- nats and kine as the datastore
- run nats, kine and k3s using overmind

see docker.nix

# Build and push docker image (with nix flakes)

```sh
nix build ".#dockerImage"
./result | gzip --fast | skopeo --insecure-policy copy docker-archive:/dev/stdin docker://registry.fly.io/my_app
```

# fly.toml example

Create volume with `flyctl volumes create myapp_data`.

```toml
app = "my_app"
kill_signal = "SIGINT"
kill_timeout = 5
processes = []

[build]
  image = "registry.fly.io/my_app"

[env]

[mounts]
source="myapp_data"
destination="/var/lib/nats"

[experimental]
  allowed_public_ports = []
  # auto_rollback = true

[[services]]
```
