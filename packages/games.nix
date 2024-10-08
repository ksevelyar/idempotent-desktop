{
  pkgs,
  lib,
  ...
}: {
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode

    wine
    lutris

    # gamepads
    ## jstest /dev/input/js0
    linuxConsoleTools
  ];
}
