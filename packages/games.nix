{pkgs, ...}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode

    lutris
    heroic
    bottles

    # wine
    wineWowPackages.stable
    # wineWowPackages.unstable
    winetricks

    # drm_info
    vulkan-tools

    # gamepads
    ## jstest /dev/input/js0
    linuxConsoleTools
  ];
}
