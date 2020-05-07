{ pkgs, lib, ... }:
{
  # services.aria2 = {
  #   openPorts = true;
  # };

  # services.kmscon = {
  #   enable = true;
  #   hwRender = true;
  #   extraConfig = "font-size=14";
  # };

  services.blueman.enable = true;

  services.tor = {
    enable = true;
    client.enable = true;
  };

  services.udisks2.enable = true;
  # services.devmon.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;
    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = lib.mkForce true;
  };
  # Allow sshd to be started manually through sudo systemctl start sshd
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [];

  services.journald.extraConfig = "SystemMaxUse=700M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = false;
}
