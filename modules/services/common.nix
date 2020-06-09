{ pkgs, lib, ... }:
{
  services.journald.extraConfig = lib.mkDefault "SystemMaxUse=500M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = false;
  services.gvfs.enable = lib.mkForce false;

  services.vnstat.enable = true;
}
