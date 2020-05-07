{ pkgs, lib, ... }:
{
  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    localuser = null;
  };

  services.mingetty.greetingLine = ''\l'';

  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  services.journald.extraConfig = lib.mkDefault "SystemMaxUse=1000M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = false;
}
