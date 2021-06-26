{ lib, ... }:
{
  services.openssh = {
    ports = [ 9922 ];
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false; # temporarily override in your host config in order to use ssh-copy-id
  };
}
