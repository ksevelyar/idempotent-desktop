# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etx/nixos/iso.nix
# dd bs=4M if=result of=/dev/sdd status=progress oflag=sync


{ config, pkgs, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./packages.nix
  ];
  isoImage.isoName = "nix-2.iso";

  # configure proprietary drivers
  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    autorun = false;
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };

  services.redshift = {
    enable = true;
    temperature.night = 4000;
    temperature.day = 6500;
  };
  location.latitude = 55.75;
  location.longitude = 37.61;

  services.blueman.enable = true;

  services.tor = {
    enable = true;
    client.enable = true;
  };

  services.nixosManual.showManual = true;
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      opensans-ttf
      nerdfonts
      powerline-fonts
      ankacoder
    ];
  };
  networking.networkmanager.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Pop-dark
        gtk-icon-theme-name=Paper-Mono-Dark
        gtk-font-name=Anka/Coder 13
        # gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name=Paper
      '';
    };

    # usr."share/icons/default/index.theme" = {
    #   text = ''
    #     [icon theme]
    #     Inherits=Paper
    #     '';
    #   };


    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        inode/directory=spacefm.desktop

        x-scheme-handler/http=firefox.desktop
        x-scheme-handler/https=firefox.desktop
        x-scheme-handler/ftp=firefox.desktop
        x-scheme-handler/chrome=firefox.desktop
        text/html=firefox.desktop
        x-scheme-handler/unknown=firefox.desktop
      '';
    };

    etc."xdg/nvim/sysinit.vim".text = builtins.readFile ./init.vim;

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.browserpass.enable = true;

  programs.fish.enable = true;
  programs.mosh.enable = true;
  programs.tmux.enable = true;

  programs.thefuck.enable = true; # https://github.com/nvbn/thefuck

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio.support32Bit = true; # Required for Steam
    bluetooth.enable = true;
  };


  time.timeZone = "Europe/Moscow";

  users.defaultUserShell = pkgs.fish;

  nix.binaryCaches = [ "https://cache.nixos.org" "https://aseipp-nix-cache.global.ssl.fastly.net" ];
}
