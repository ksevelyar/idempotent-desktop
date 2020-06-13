# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
{ config, pkgs, lib, vars, ... }:
{
  vars.user = "mrpoppybutthole";

  users.users.root = {
    # id
    # To generate hashed password run mkpasswd -m sha-512
    initialHashedPassword = lib.mkForce "$6$zKk1qNy.84$mVGFT2YYt39K2NI17T7skDyyVXf8LVMG.7vF.JMrKqTq6INet9eLj8BUeLR.QAKdU2cyGELQ04UP6GFIG4LX./";
  };

  home-manager = {
    users.${vars.user} = {
      home.file."Wallpapers/Season-01-Gas-station-by-dutchtide.png".source = ../assets/wallpapers/Season-01-Gas-station-by-dutchtide.png;
    };
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
    sudo mv /mnt/etc/nixos{,.bak}

    # downloand repo
    sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
  '';
}
