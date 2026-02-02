{
  services.openssh = {
    enable = true;
    extraConfig = ''
      permitRootLogin = yes
      passwordAuthentication = yes
    '';
  };
}
