# Nix

## Manual tests

You can build any configuration without leaving trash:

`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/hk47.nix --no-out-link`
`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/skynet.nix --no-out-link`
`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/kitt2000.nix --no-out-link`

## Autotests

Yay! You can autotest all your linux configurations! You should because you can do it fo free, with simple setup.

Combine previous commands and a binary cache for CI.

### [Cachix](https://cachix.org/) Free 10GB binary cache for public repos

`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/hk47.nix --no-out-link | cachix push idempotent-desktop`

### [Example with Travis CI](https://github.com/ksevelyar/dotfiles/blob/master/.travis.yml)

Travis is both free and slow, don't forget to populate Cachix for your tests:

## Tutorials

- [nixcloud.io/tour](https://nixcloud.io/tour)
- [pills](https://nixos.org/nixos/nix-pills/why-you-should-give-it-a-try.html)
- [options](https://nixos.org/nixos/options.html)
- [manual](https://nixos.org/nixos/manual/')
