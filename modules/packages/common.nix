# nixos.option programs

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
      nmap
      wget
      curl
      aria2
      translate-shell
      brightnessctl
      youtube-dl

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

      # mail & tasks
      astroid
      notmuch
      offlineimap
      taskwarrior

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

      # fs
      unzip
      unrar
      atool
      ffmpeg
      bind
      parted
      ffsend
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
      rclone # rclone mount gdrive: ~/gdrive/

      # im
      toxic
      neomutt

      # bells and whistles
      cmatrix
    ];
}
