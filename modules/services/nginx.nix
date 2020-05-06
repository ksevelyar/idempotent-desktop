{
  services.nginx = {
    enable = true;
    virtualHosts."dobroserver.ru" = {
      enableACME = true;
      forceSSL = true;
      root = "/home/ksevelyar/dobroserver";
    };
  };
  # Optional: You can configure the email address used with Let's Encrypt.
  # This way you get renewal reminders (automated by NixOS) as well as expiration emails.
  security.acme.certs = {
    "blog.example.com".email = "ksevelyar@gmail.com";
  };
}
