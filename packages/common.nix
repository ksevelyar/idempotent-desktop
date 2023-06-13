{ config, pkgs, lib, ... }:
{
  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
    Host *.local
      Port 9922
    '';
  };

  environment.systemPackages = with pkgs;
    [
      # sys
      direnv
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

      # gtd
      bartib

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
      unar
      unzip
      p7zip
      viu
      zip
      zoxide

      # media
      cmus
    ];
}
