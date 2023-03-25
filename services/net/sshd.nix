{ lib, ... }:
{
  systemd.services.sshd.wantedBy = lib.mkForce [ ]; # sudo systemctl start sshd

  services.openssh = {
    enable = true;
    ports = [ 9922 ];
  };

  services.openssh.settings = {
    permitRootLogin = "no";
    passwordAuthentication = false; # temporarily override in your host config in order to use ssh-copy-id
  };
}
