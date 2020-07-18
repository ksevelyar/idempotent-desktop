{ config, pkgs, ... }:
{
  # Required for Steam
  hardware = {
    pulseaudio.support32Bit = true;
    opengl.driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs;
    [
      # gamepads
      # jstest /dev/input/js0
      linuxConsoleTools

      # emulators & platforms
      steam
      wineFull
      # retroarchBare
      # anbox
      # (steam.override { nativeOnly = true; })
      # stable.playonlinux # https://www.playonlinux.com/en/supported_apps-1-0.html

      # text 
      dwarf-fortress
      nethack
      rogue

      # gui
      # jdk11 # minecraft
      xonotic
      wesnoth
      stepmania
      opendune
      # yquake2
      openra
      gzdoom
      # quakespasm
    ];
}
