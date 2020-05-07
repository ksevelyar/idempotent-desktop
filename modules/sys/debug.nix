{ lib, ... }:
{
  boot.plymouth.enable = lib.mkForce false;

  security.sudo = {
    enable = true;
    # Allow passwordless sudo 
    wheelNeedsPassword = lib.mkForce false;
  };
  services.openssh = {
    enable = lib.mkForce true;
    permitRootLogin = lib.mkForce "yes";
    passwordAuthentication = lib.mkForce true;
  };
  systemd.services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
}
