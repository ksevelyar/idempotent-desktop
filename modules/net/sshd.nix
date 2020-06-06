{ lib, ... }:
{
  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false; # temporarily override in your host config in order to use ssh-copy-id

    # listenAddresses = [ { addr = "192.168.3.1"; port = 22; } { addr = "0.0.0.0"; port = 61816; } ];
  };
  systemd.services.sshd.wantedBy = lib.mkForce []; # disable autostart
}
