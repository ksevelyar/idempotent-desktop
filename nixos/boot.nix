{ config, pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "quiet" ];
  boot.consoleLogLevel = 3;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    # device = "/dev/sda"; # MBR/BIOS
    version = 2;
    backgroundColor = "#35246e";
    memtest86.enable = true;
    configurationLimit = 42;
    useOSProber = true;

    #extraConfig = "set theme=${pkgs.breeze-grub}/grub/themes/breeze/theme.txt";
    splashImage = "/etc/nixos/grub.jpg";
    splashMode = "normal";
    font = "/etc/nixos/ter-u16n.pf2";
    extraConfig = ''
      set menu_color_normal=light-blue/black
      set menu_color_highlight=black/light-blue
    '';
  };

  boot.tmpOnTmpfs = false;
  boot.plymouth.enable = false;
}
