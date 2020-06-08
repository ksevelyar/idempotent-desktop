# nixos.option programs

{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  programs.fish.enable = true;
  programs.mosh.enable = true;

  environment.systemPackages = with pkgs;
    [
      # sys
      fzf
      ripgrep
      fd
      cachix
      home-manager
      libqalculate # qalc
      exa
      bat
      micro
      watchman
      sipcalc
      tldr
      git
      gitAndTools.delta
      bash
      mkpasswd
      file
      memtest86plus
      jq
      miller
      ccze
      lnav
      nix-du
      graphviz
      nmap
      wget
      curl
      aria2
      translate-shell
      brightnessctl
      youtube-dl
      ddgr
      entr
      termdown

      # monitoring 
      bandwhich
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
      isync # sync imap
      msmtp # send mail
      notmuch # index and search mail
      neomutt # terminal mail client
      mu # https://zmalltalker.com/linux/mu.html
      taskwarrior # todo & tasks

      # sec
      openvpn
      tomb

      # fs
      unzip
      unrar
      atool
      bind
      parted
      ffsend
      fd

      # curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
      nnn
      viu

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
      # neomutt

      # bells and whistles
      cmatrix
    ];
}
