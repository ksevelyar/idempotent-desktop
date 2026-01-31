{pkgs, ...}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud

    cabextract
    heroic

    # wine
    wineWowPackages.stable
    winetricks

    # drm_info
    vulkan-tools

    # gamepads
    ## jstest /dev/input/js0
    linuxConsoleTools
  ];
}
