{ config, pkgs, lib, ... }:
{
  programs.fish.enable = true;
  programs.mosh.enable = true;

  environment.systemPackages = with pkgs;
    [
      # sys
      aria2
      bat
      cachix
      ccze
      file
      fzf
      git
      gitAndTools.delta # https://github.com/dandavison/delta
      jq
      lnav
      mkpasswd
      nmap
      ripgrep
      sd
      tealdeer # aliased to h
      translate-shell
      woeusb # write win10.iso to usb drive

      # monitoring
      gotop
      inxi # inxi -Mxxxa
      hwinfo
      inetutils
      iotop
      lm_sensors
      lshw
      lsof
      neofetch
      pciutils # lspci
      smartmontools
      usbutils # lsusb

      # sec
      cryptsetup
      pwgen

      # fs
      broot
      atool
      bind
      dosfstools
      exa
      exfat
      fd
      ffsend
      gptfdisk
      mtools
      ncdu
      ntfs3g
      parted
      rsync
      sshfs
      sshfs-fuse
      unrar
      unzip
      viu
      zip
      zoxide

      # media
      cmus
    ];
}
