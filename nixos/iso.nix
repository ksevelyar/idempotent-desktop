# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/iso.nix --max-jobs 4
# dd bs=4M if=result of=/dev/sdd status=progress oflag=sync


{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./modules/aliases.nix
    ./modules/packages.nix
    ./modules/fonts.nix
  ];
  isoImage.isoName = "nixos.iso";

  nixpkgs.overlays = [ (import ./overlays) ];
  # configure proprietary drivers
  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true; # Required for Steam
    opengl.driSupport32Bit = true; # Required for Steam
  };
  sound.enable = true;

  # boot.kernelModules = [ "wl" ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  # Enable SSH in the boot process.
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
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
  networking.networkmanager.enable = true;

  qt5 = { style = "gtk2"; platformTheme = "gtk2"; };
  environment = {
    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Ant-Dracula
        gtk-icon-theme-name=Paper-Mono-Dark
        gtk-font-name=Anka/Coder 13
        # gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name=Vanilla-DMZ
      '';
    };

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

  time.timeZone = "Europe/Moscow";

  users.defaultUserShell = pkgs.fish;

  users.users.root = {
    # jkl
    initialHashedPassword = lib.mkForce "$6$krVCM45j$6lYj1WKEX8q7hMZGG6ctAG6kQDDND/ngpGOwENT1TIOD25F0yep/VvIuL.v9XyRntLJ61Pr8r7djynGy5lh3x0";
  };

  users.users.nixos = {
    # jkl
    initialHashedPassword = lib.mkForce "$6$krVCM45j$6lYj1WKEX8q7hMZGG6ctAG6kQDDND/ngpGOwENT1TIOD25F0yep/VvIuL.v9XyRntLJ61Pr8r7djynGy5lh3x0";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };


  nix.binaryCaches = [ "https://cache.nixos.org" "https://aseipp-nix-cache.global.ssl.fastly.net" ];


  services.mingetty.helpLine = ''
    The "nixos" and "root" accounts have "jkl" passwords.

    .     .       .  .   . .   .   . .    +  .
      .     .  :     .    .. :. .___---------___.
           .  .   .    .  :.:. _".^ .^ ^.  '.. :"-_. .
        .  :       .  .  .:../:            . .^  :.:\.
            .   . :: +. :.:/: .   .    .        . . .:\
     .  :    .     . _ :::/:               .  ^ .  . .:\
      .. . .   . - : :.:./.                        .  .:\
      .      .     . :..|:                    .  .  ^. .:|
        .       . : : ..||        .                . . !:|
      .     . . . ::. ::\(                           . :)/
     .   .     : . : .:.|. ######              .#######::|
      :.. .  :-  : .:  ::|.#######           ..########:|
     .  .  .  ..  .  .. :\ ########          :######## :/
      .        .+ :: : -.:\ ########       . ########.:/
        .  .+   . . . . :.:\. #######       #######..:/
          :: . . . . ::.:..:.\           .   .   ..:/
       .   .   .  .. :  -::::.\.       | |     . .:/
          .  :  .  .  .-:.":.::.\             ..:/
     .      -.   . . . .: .:::.:.\.           .:/
    .   .   .  :      : ....::_:..:\   ___.  :/
       .   .  .   .:. .. .  .: :.:.:\       :/
         +   .   .   : . ::. :.:. .:.|\  .:/|
         .         +   .  .  ...:: ..|  --.:|
    .      . . .   .  .  . ... :..:.."(  ..)"
     .   .       .      :  .   .: ::/  .  .::\

    Type `x' to
    start the graphical user interface.
  '';
}
