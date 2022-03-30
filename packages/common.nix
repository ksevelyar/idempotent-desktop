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
      tealdeer # aliased to h
      git
      mkpasswd
      file
      ccze
      lnav
      nmap
      aria2
      translate-shell
      taskwarrior # todo & tasks
      woeusb # write win10.iso to usb drive
      jq

      # monitoring
      lm_sensors
      lsof
      hwinfo
      smartmontools
      gotop
      iotop
      neofetch
      lshw
      pciutils # lspci
      usbutils # lsusb
      inetutils

      # sec
      cryptsetup
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
      exa
      zoxide
      dosfstools
      mtools
      sshfs
      ntfs3g
      exfat
      sshfs-fuse
      rsync
      rclone # rclone mount gdrive: ~/gdrive/
      pigz

      # media
      moc
    ];
}
