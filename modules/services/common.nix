{ pkgs, lib, ... }:
{
  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    localuser = null;
  };


  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;

    # listenAddresses = [ { addr = "192.168.3.1"; port = 22; } { addr = "0.0.0.0"; port = 61816; } ];
  };

  services.journald.extraConfig = lib.mkDefault "SystemMaxUse=1000M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = false;
  services.gvfs.enable = lib.mkForce false;
}
