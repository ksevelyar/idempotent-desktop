{ config, pkgs, lib, ... }:
{

  programs.fish.enable = true;
  programs.mosh.enable = true;

  environment.systemPackages = with pkgs;
    [
      # sys
      cachix
      fzf
      ripgrep
      sd
      bat
      gitAndTools.delta # https://github.com/dandavison/delta
      libqalculate # qalc
      watchman
      sipcalc
      tealdeer
      git
      mkpasswd
      file
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
      sampler
      taskwarrior # todo & tasks
      procs
      hyperfine
      woeusb # write win10.iso to usb drive

      # data
      jq
      miller

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
      zip
      unzip
      unrar
      atool
      bind
      parted
      gptfdisk
      ffsend
      nnn
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
    ];
}
