{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  # Required for Steam
  hardware = {
    pulseaudio.support32Bit = true;
    opengl.driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs;
    [
      # text
      dwarf-fortress
      nethack
      rogue

      # gui
      xonotic
      wesnoth
      stepmania

      # emulators & platforms
      anbox
      gzdoom
      quakespasm
      stable.steam
      lutris
      stable.playonlinux # https://www.playonlinux.com/en/supported_apps-1-0.html
    ];
}
