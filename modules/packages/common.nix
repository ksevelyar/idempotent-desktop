# nixos.option programs

{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
  hunter = pkgs.callPackage ./hunter.nix {};
in
{

  programs.fish.enable = true;
  programs.mosh.enable = true;

  environment.systemPackages = with pkgs;
    [
      # sys
      fzf
      ripgrep
      sd
      bat
      gitAndTools.delta # https://github.com/dandavison/delta
      cachix
      home-manager
      libqalculate # qalc
      micro
      watchman
      sipcalc
      tealdeer
      git
      mkpasswd
      file
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
      procs
      hyperfine

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
      inetutils

      # mail & tasks
      isync # sync imap
      msmtp # send mail
      notmuch # index and search mail
      notmuch-bower # notmuch tui
      lynx # bower dep
      mailcap # bower dep

      # im
      toxic

      # sec
      cryptsetup
      tomb
      pwgen

      # fs
      fd
      exa
      unzip
      unrar
      atool
      bind
      parted
      ffsend
      hunter
      viu
      ncdu
      du-dust
      exa
      zoxide
      dosfstools
      mtools
      sshfs
      ntfs3g
      exfat
      sshfsFuse
      rsync
      rclone # rclone mount gdrive: ~/gdrive/
      pigz

      # media
      moc

      # bells and whistles
      cava
      cmatrix

      # games for live usb
      rogue
      nethack
    ];
}
