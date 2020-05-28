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
      home-manager
      libqalculate # qalc
      exa
      bat
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

      # monitoring 
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
      # To create a 100MB tomb called “secret” do:
      # tomb dig -s 100 secret.tomb
      # tomb forge secret.tomb.key
      # tomb lock secret.tomb -k secret.tomb.key
      tomb

      # We can add existing passwords to the store with insert:
      # pass insert Business/cheese-whiz-factory
      passExtensions.pass-audit
      passExtensions.pass-genphrase
      # passExtensions.pass-import
      passExtensions.pass-otp
      passExtensions.pass-tomb
      passExtensions.pass-update
      (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-genphrase pass-update ]))
      # ripasso-cursive
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
      unar
      unzip
      unrar
      atool

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
      rclone

      # im
      toxic
      neomutt

      # bells and whistles
      cmatrix
    ];
}
