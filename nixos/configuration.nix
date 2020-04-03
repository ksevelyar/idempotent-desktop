# sudo nix-channel --add https://nixos.org/channels/nixos-19.09 stable
# sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-channel --update

{ config, pkgs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./debug.nix
      ./boot.nix
      ./packages.nix
      ./services.nix
      # ./laptop.nix
      ./users/ksevelyar.nix
      ./hosts/laundry.nix
    ];

  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio.support32Bit = true; # Required for Steam
    bluetooth.enable = true;
  };

  # Enable sound.
  sound.enable = true;

  virtualisation.libvirtd = {
    enable = false;
    qemuPackage = pkgs.qemu_kvm;
  };

  # Enable the X11 windowing system.
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      siji # https://github.com/stark/siji
      tamsyn # http://www.fial.com/~scott/tamsyn-font/
      opensans-ttf
      nerdfonts
      powerline-fonts
      ankacoder
    ];
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
      127.0.0.1 li.lcl
    '';

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  i18n.defaultLocale = "en_US.UTF-8";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.browserpass.enable = true;

  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.tmux.enable = true;
  programs.qt5ct.enable = true;

  programs.thefuck.enable = true; # https://github.com/nvbn/thefuck


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
