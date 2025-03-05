{
  pkgs,
  lib,
  ...
}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode

    lutris
    bottles

    wine
    winetricks

    # gamepads
    ## jstest /dev/input/js0
    linuxConsoleTools
  ];
}
