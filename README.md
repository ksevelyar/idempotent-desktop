![screen](https://i.imgur.com/uzHIEZS.png)

```
sudo nix-channel --add https://nixos.org/channels/nixos-19.09 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo mkdir -p /storage/tmp
sudo nixos-rebuild switch --keep-going
```
