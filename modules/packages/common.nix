{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  nix = {
    useSandbox = true;
    maxJobs = lib.mkDefault 2;
    extraOptions = ''
      connect-timeout = 10 
      http-connections = 4
    '';
  };

  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs;
    [
      # sys
      kakoune
      watchman
      (
        python3.withPackages (
          ps: with ps; [
            httpserver
            pywal
          ]
        )
      )

      # navi
      sipcalc
      lsof
      cheat
      tldr
      git
      gitAndTools.diff-so-fancy
      bash
      lm_sensors
      mkpasswd
      file
      memtest86plus
      jq
      lshw
      pciutils # lspci
      usbutils # lsusb
      psmisc # pstree, killall
      bat
      inetutils

      # sec
      tomb
      # pass
      # We can add existing passwords to the store with insert:
      # pass insert Business/cheese-whiz-factory
      passExtensions.pass-audit
      passExtensions.pass-genphrase
      passExtensions.pass-import
      passExtensions.pass-otp
      passExtensions.pass-tomb
      passExtensions.pass-update
      (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb ]))
      ripasso-cursive
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

      # monitoring 
      hwinfo
      smartmontools
      gotop
      htop
      iotop
      iftop
      neofetch

      # fs
      bind
      unzip
      unrar
      p7zip
      atool
      parted
      fasd
      mc
      fd
      nnn
      ncdu
      tree
      dosfstools
      mtools
      sshfs
      ntfs3g
      exfat
      sshfsFuse
      rsync
    ];
}
