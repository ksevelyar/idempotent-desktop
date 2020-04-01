{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "none+xmonad";
      sessionCommands = ''
        sh ~/.fehbg &
        sh ~/.config/polybar/launch.sh &
        xsetroot -cursor_name left_ptr
        xbindkeys &
        xset -dpms
      '';
    };

    displayManager.lightdm = {
      enable = true;
      background = "/etc/nixos/grub.jpg";


      greeters.gtk = {
        enable = true;
        cursorTheme = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
          # user = "ksevelyar";
          # extraConfig = ''
          #   [greeter]
          #   show-password-label = false
          #   [greeter-theme]
          #   background-image = ""
          # '';
        };
      };
    };

    libinput = {
      enable = true;
      accelProfile = "flat"; # flat profile for touchpads
      # naturalScrolling = true;
      # disableWhileTyping = true;
    };
    # videoDrivers = [ "nouveau" "intel" "amdgpu" ];
    # videoDrivers = [ "intel" ];
    # synaptics.enable = false; # disable synaptics

    # flat profile for mice
    config = ''
      Section "InputClass"
        Identifier     "My mouse"
        Driver         "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
      EndSection
    '';
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager = {
      xterm.enable = false;
    };


    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      xmonad.extraPackages = hpkgs: [
        hpkgs.xmonad-contrib
        hpkgs.xmonad-extras
        hpkgs.xmonad
      ];
    };
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    #   drivers = [ pkgs.gutenprint pkgs.hplip ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply"
    ATTR{status}=="Discharging"
    ATTR{capacity}=="[0-10]"
    RUN+="${pkgs.libnotify}/bin/notify-send 'Low Battery' 'HRU'"
  '';

  # services.picom.enable = false;
  # services.picom.fade = false;
  # services.picom.shadow = false;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  services.aria2 = {
    openPorts = true;
    downloadDir = "/storage/tmp";
  };

  services.nfs.server.enable = true;
  services.nfs.server.statdPort = 4000;
  services.nfs.server.lockdPort = 4001;
  services.nfs.server.mountdPort = 4002;
  services.nfs.server.exports = ''
    /srv         192.168.0.1/24(ro,all_squash,insecure,fsid=0,crossmnt)
    /srv/storage 192.168.0.1/24(rw,nohide,all_squash,insecure)
    /srv/vvv     192.168.0.1/24(rw,nohide,all_squash,insecure)
  '';

  fileSystems."/srv/storage/" = {
    device = "/storage/tmp";
    options = [ "bind" ];
  };

  fileSystems."/srv/vvv/" = {
    device = "/storage/vvv";
    options = [ "bind" ];
  };

  # Auto-detect the connected display hardware and load the appropriate X11 setup using xrandr
  # services.autorandr.enable = true;

  services.syncthing = {
    enable = false;
    user = "ksevelyar";
    dataDir = "/home/ksevelyar/.syncthing";
    openDefaultPorts = true;
  };

  services.blueman.enable = true;
  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=85
    STOP_CHARGE_THRESH_BAT0=95
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
  '';

  services.tor = {
    enable = true;
    client.enable = true;
  };


  services.udisks2.enable = true;
  # services.devmon.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;

    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.openssh.permitRootLogin = "no";
  services.openssh.enable = true;
  # Allow sshd to be started manually through sudo systemctl start sshd
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [];

  services.journald.extraConfig = "SystemMaxUse=500M";

  services.fail2ban.enable = true;
  services.fail2ban.jails.DEFAULT = ''
    ignoreip = 127.0.0.1/8
    bantime = 600
    findtime = 600
    maxretry = 3
    backend = auto
    enabled = true
  '';

  services.nixosManual.showManual = true;
}
