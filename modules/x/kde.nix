{ config, pkgs, lib, vars, ... }:
{
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;


  services.xserver.desktopManager.plasma5.enable = true;
}
