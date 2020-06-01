# Nix

## Manual tests

You can build any configuration without leaving trash:

`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/hk47.nix --no-out-link`
`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/skynet.nix --no-out-link`
`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/kitt2000.nix --no-out-link`

## Autotests

Combine previous commands, Cachix and CI.

[Example with Travis CI](https://github.com/ksevelyar/dotfiles/blob/master/.travis.yml)

Travis is both free and slow, don't forget to populate Cachix for your tests:

`nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/hosts/hk47.nix --no-out-link | cachix push idempotent-desktop`

## Tutorials

- [nixcloud.io/tour](https://nixcloud.io/tour)
- [pills](https://nixos.org/nixos/nix-pills/why-you-should-give-it-a-try.html)
- [options](https://nixos.org/nixos/options.html)
- [manual](https://nixos.org/nixos/manual/')
