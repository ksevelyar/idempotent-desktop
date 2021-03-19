{ lib, ... }:
{
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

  systemd.services.sshd.wantedBy = [ "multi-user.target" ];
}
