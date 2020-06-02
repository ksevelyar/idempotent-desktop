{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "p7zip-16.02"
  ];

  nix = {
    useSandbox = true;
    maxJobs = lib.mkDefault 4;
    extraOptions = ''
      connect-timeout = 10 
    '';
  };

  programs.wireshark.enable = true;
  programs.bandwhich.enable = true;
  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs;
    [
      # sys
      cachix
      home-manager
      libqalculate # qalc
      exa
      bat
      kakoune
      watchman
      sipcalc
      tldr
      git
      gitAndTools.diff-so-fancy
      gitAndTools.tig
      bash
      mkpasswd
      file
      memtest86plus
      jq
      ccze
      nix-du
      graphviz

      # monitoring 
      iperf3
      lm_sensors
      lsof
      hwinfo
      smartmontools
      gotop
      htop
      iotop
      neofetch
      lshw
      pciutils # lspci
      usbutils # lsusb
      psmisc # pstree, killall
      inetutils

      # sec
      openvpn
      tomb

      passExtensions.pass-audit
      passExtensions.pass-genphrase
      passExtensions.pass-import
      passExtensions.pass-otp
      passExtensions.pass-update
      (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-genphrase pass-import pass-update ]))
      gopass

      # cli
      taskwarrior
      nmap
      wget
      curl
      aria2
      translate-shell
      websocat
      brightnessctl
      youtube-dl

      # fs
      ffsend
      unar
      unzip
      unrar
      atool
      ffmpeg

      bind
      parted

      fd
      nnn
      ncdu
      exa
      z-lua
      dosfstools
      mtools
      sshfs
      ntfs3g
      exfat
      sshfsFuse
      rsync
      # rclone mount gdrive: ~/gdrive/
      rclone

      # im
      toxic
      neomutt

      # bells and whistles
      cmatrix
    ];
}
