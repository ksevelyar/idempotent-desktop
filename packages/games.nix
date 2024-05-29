{pkgs, ...}: {
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
  };

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode

    # gamepads
    ## jstest /dev/input/js0
    linuxConsoleTools
  ];
}
