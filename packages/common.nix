{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.ssh = {
    askPassword = "";
    startAgent = true;
    extraConfig = ''
      Host *.local
        Port 9922
    '';
  };

  environment.defaultPackages = with pkgs; [
    # sys
    strace
    nix-tree
    direnv
    bat
    cachix
    ccze
    file
    fzf
    git
    delta # https://github.com/dandavison/delta
    jq
    lnav
    mkpasswd
    ripgrep
    sd
    tealdeer # aliased to h
    translate-shell
    procs

    # net
    nmap
    sing-box

    # monitoring
    gotop
    bottom
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
    eza
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
  ];
}
