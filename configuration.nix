# sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-channel --update
# sudo nixos-rebuild switch --upgrade --keep-going
# bu

{ config, pkgs, lib, ... }:
{
  imports =
    [
      # passwordless sudo, sshd on start (and allows root)
      # sshfs root@192.168.0.10:/ ~/dobroserver
      # ssh-copy-id root@192.168.0.10
      # ./modules/debug.nix
      ./users/ksevelyar.nix
      ./hosts/laundry.nix
    ];

  boot.tmpOnTmpfs = true;
  networking.firewall.enable = true;
  networking.networkmanager.enable = lib.mkDefault true; # run nmtui for wi-fi

  nix = {
    useSandbox = true;
    maxJobs = lib.mkDefault 2;
    extraOptions = ''
      connect-timeout = 10 
      http-connections = 10
    '';
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
}
