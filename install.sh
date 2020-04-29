sudo cp -ra /etx/nixos{,.bak}

sudo mkdir -p /storage/tmp
sudo mkdir -p /storage/vvv

sudo git clone git@github.com:ksevelyar/dotfiles.git /etc/nixos

sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update

sudo nixos-rebuild switch --keep-going
