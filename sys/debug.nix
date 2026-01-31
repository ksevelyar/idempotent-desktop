{lib, ...}: {
  security.sudo = {
    enable = true;
    wheelNeedsPassword = lib.mkForce false;
  };

  services.openssh = {
    enable = true;
    extraConfig = ''
      permitRootLogin = yes
      passwordAuthentication = yes
    '';
  };
}
