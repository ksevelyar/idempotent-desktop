{
  security.acme.acceptTerms = true;

  services.nginx = {
    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    commonHttpConfig = ''
      charset utf-8;
      source_charset utf-8;
    '';

    enable = true;
    virtualHosts."legacy-intelligence.life" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/li";
    };
  };
  # Optional: You can configure the email address used with Let's Encrypt.
  # This way you get renewal reminders (automated by NixOS) as well as expiration emails.
  security.acme.certs = {
    "legacy-intelligence.life".email = "ksevelyar@gmail.com";
  };
}
