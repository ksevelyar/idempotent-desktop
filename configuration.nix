# sudo nix-channel --add https://nixos.org/channels/nixos-19.09 stable
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-channel --update
# bu

{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./modules/aliases.nix
      ./modules/debug.nix
      ./modules/boot.nix
      ./modules/packages.nix
      ./modules/services.nix
      # ./modules/laptop.nix
      ./modules/fonts.nix
      ./users/ksevelyar.nix
      ./hosts/laundry.nix
    ];

  nixpkgs.overlays = [ (import ./overlays) ];
  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true; # Required for Steam
    opengl.driSupport32Bit = true; # Required for Steam
  };
  sound.enable = true;

  virtualisation.libvirtd = {
    enable = false;
    qemuPackage = pkgs.qemu_kvm;
  };

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    # Transmission
    51413

    # VNC
    5900

    # NFS
    111
    2049
    4000
    4001
    4002

    # Dev
    8080
  ];
  networking.firewall.allowedUDPPorts = [ 51413 5900 111 2049 4000 4001 4002 8080 ];
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.extraHosts =
    ''
      127.0.0.1 l.lcl
    '';

  users.defaultUserShell = pkgs.fish;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    binaryCaches = [ "https://cache.nixos.org" "https://aseipp-nix-cache.global.ssl.fastly.net" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}