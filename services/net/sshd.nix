{ lib, ... }:
{
  systemd.services.sshd.wantedBy = lib.mkForce []; # sudo systemctl start sshd
  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false; # temporarily override in your host config in order to use ssh-copy-id
  };
}
