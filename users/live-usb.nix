{ config, pkgs, lib, vars, ... }:
{
  vars.user = "mrpoppybutthole";

  imports =
    [
      ./shared.nix
    ];

  users.users.root = {
    # jkl
    initialHashedPassword = lib.mkForce "$6$krVCM45j$6lYj1WKEX8q7hMZGG6ctAG6kQDDND/ngpGOwENT1TIOD25F0yep/VvIuL.v9XyRntLJ61Pr8r7djynGy5lh3x0";
  };
  users.users.${vars.user} = {
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  services.mingetty.autologinUser = lib.mkForce vars.user;
  services.mingetty.greetingLine = lib.mkForce ''\l'';

  environment.shellAliases = {
    wire-dotfiles = "sh /etc/scripts/wire-dotfiles.sh";
  };
  # NOTE: /mnt and /mnt/boot should be mounted before this command
  environment.etc."/scripts/wire-dotfiles.sh".text = ''
    refresh-channels
    # create blank hardware-configuration.nix & configuration.nix
    sudo nixos-generate-config --root /mnt
    bat /mnt/etc/nixos/*.nix
    sudo cp -ra /mnt/etc/nixos{,.bak}

    # downloand repo 
    sudo git clone https://github.com/ksevelyar/dotfiles.git /mnt/etc/nixos
    bat /mnt/etc/nixos/*.nix
    nvim /mnt/etc/nixos/configuration.nix
  '';
}
