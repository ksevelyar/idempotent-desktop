{ pkgs, ... }:
{
  # Required for Steam
  hardware = {
    pulseaudio.support32Bit = true;
    opengl.driSupport32Bit = true;
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs;
    [
      ## gamepads
      # jstest /dev/input/js0
      linuxConsoleTools

      ## text
      # dwarf-fortress
      # nethack
      # rogue

      ## gui
      # xonotic
      # wesnoth
      # stepmania
      # yquake2
      # openra
    ];
}
