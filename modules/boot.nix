{ lib, ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelParams = [ "quiet" ];
  # boot.consoleLogLevel = 3;

  boot.cleanTmpDir = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      # device = "/dev/sda"; # MBR/BIOS
      version = 2;
      backgroundColor = "#35246e";
      memtest86.enable = true;
      configurationLimit = 42;
      useOSProber = true;

      # extraConfig = "set theme=($drive1)//grub/themes/fallout-grub-theme/theme.txt";
      splashImage = "/etc/nixos/assets/grub.png";
      splashMode = "normal";
      font = "/etc/nixos/assets/ter-u16n.pf2";
      extraConfig = ''
        set menu_color_normal=light-blue/black
        set menu_color_highlight=black/light-blue
      '';
    };
  };

  boot.loader.grub = {};
}
