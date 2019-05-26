# terranix NixOS Server Example

Setup containing opinionated modules to deploy
[NixOS servers](https://nixos.org/)
on
[hcloud](https://www.hetzner.com/cloud)
using
[nixos-infect](https://github.com/elitak/nixos-infect).
Provisioning uploads the
nixos-infect
script and applys it,
after uploading additional NixOS configuraiton files.

The [nginx](https://www.nginx.com/)
service is configured by a template generated by terraform
containing the IP addresses of the other
servers.
To access the domains you have to
update your `/etc/hosts`.

## How to Run

to see the JSON output :

```shell
nix-shell --run terranix
```

to roll out this setup:

```shell
nix-shell --run "terranix > config.tf.json && terraform init && terraform apply"
```

Make sure your passwordstore [is setup correctly](#password).

### Password

Passwords are managed by
[pass the password-store](https://www.passwordstore.org/).

You need a
[hcloud token](https://docs.hetzner.cloud/#overview-getting-started)
which is stored under
`development/hetzner.com/api-token`
in your passwordstore.
(Of course you can change that by adjusting the `./shell.nix`).