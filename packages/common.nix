{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.command-not-found.enable = true;
  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.ssh = {
    askPassword = "";
    startAgent = true;
    extraConfig = ''
      Host *
        ServerAliveInterval 20
        ServerAliveCountMax 5
    '';
  };

  environment.defaultPackages = with pkgs; [
    # sys
    inputs.disko.packages.${pkgs.system}.disko
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
    zellij
    opencode

    # net
    nmap
    tcpdump

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
    fastfetch
    pciutils # lspci
    smartmontools
    usbutils # lsusb

    # sec
    # FIXME: evaluation warning: 'system' has been renamed to/replaced by 'stdenv.hostPlatform.system'
    inputs.agenix.packages.${pkgs.system}.default
    cryptsetup
    pwgen

    # fs
    yazi
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
