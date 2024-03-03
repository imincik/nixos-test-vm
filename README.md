# Test NixOS VMs

## VM list

* vm     - bare bones VM
* k3s    - lightweight Kubernetes (k3s)
* xfce   - XFCE desktop


## Usage

* Launch VM from github
```
  nix run github:imincik/nixos-vms#<VM-NAME>

    ex.:

  nix run github:imincik/nixos-vms#xfce
```

* Launch VM from cloned source code
```
  nix run .#<VM-NAME>

    ex.:

  nix run .#xfce
```

### Passwords

* `root` : root
* `test` : test
