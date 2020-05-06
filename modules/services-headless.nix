{ pkgs, ... }:
{
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

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

  services.journald.extraConfig = "SystemMaxUse=1000M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = false;
}
