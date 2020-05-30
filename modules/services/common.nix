{ pkgs, lib, ... }:
{
  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    localuser = null;
  };

  services.journald.extraConfig = lib.mkDefault "SystemMaxUse=1000M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = false;
  services.gvfs.enable = lib.mkForce false;

  services.vnstat.enable = true;
}
