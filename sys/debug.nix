{ lib, ... }:
{
  security.sudo = {
    enable = true;
    # Allow passwordless sudo
    wheelNeedsPassword = lib.mkForce false;
  };

  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  services.openssh = {
    enable = true;
    extraConfig = ''
      permitRootLogin = yes
      passwordAuthentication = yes
    '';
  };
}
