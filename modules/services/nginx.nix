{
  security.acme.acceptTerms = true;

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    commonHttpConfig = ''
      charset utf-8;
      source_charset utf-8;
    '';

    virtualHosts."legacy-intelligence.life" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/legacy-intelligence.life";
    };

    virtualHosts."preview.network" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/legacy-intelligence.life";
    };
    virtualHosts."map.preview.network" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/drawable-map/public";

      locations."/polygons" = {
        proxyPass = http://127.0.0.1:3000;
      };
    };
  };

  security.acme.email = "ksevelyar@gmail.com";
}
