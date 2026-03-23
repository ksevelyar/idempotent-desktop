{
  networking = {
    nameservers = ["127.0.0.1"];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      block_ipv6 = true;
      require_dnssec = false;
      require_nolog = true;
      require_nofilter = true;
      ipv4_servers = true;
      ipv6_servers = false;
      server_names = [
        "cloudflare"
        "quad9-dnscrypt-ip4-filter-pri"
        "google"
        "scaleway-fr"
      ];
    };
  };
}
