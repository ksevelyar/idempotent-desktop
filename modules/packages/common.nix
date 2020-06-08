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
      bat
      gitAndTools.delta # https://github.com/dandavison/delta
      cachix
      home-manager
      libqalculate # qalc
      micro
      watchman
      sipcalc
      tldr
      git
      bash
      mkpasswd
      file
      memtest86plus
      jq
      miller
      ccze
      lnav
      nmap
      wget
      curl
      aria2
      translate-shell
      brightnessctl
      youtube-dl
      ddgr # cli duckduckgo
      googler # cli google
      entr
      termdown
      imagemagick
      sampler
      taskwarrior # todo & tasks

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
      notmuch-bower
      lynx
      mailcap
      mu # https://zmalltalker.com/linux/mu.html

      # im
      toxic

      # sec
      openvpn
      tomb

      # fs
      fd
      exa
      unzip
      unrar
      atool
      bind
      parted
      ffsend
      nnn # curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
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

      # media
      cmus
      moc
      glava

      # bells and whistles
      cmatrix

      # games for live usb
      rogue
      nethack
    ];
}
