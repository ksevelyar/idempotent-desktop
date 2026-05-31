{
  services.avahi = {
    enable = true;
    ipv6 = false;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      domain = true;
      workstation = true;
    };
  };
}
