{
  config,
  pkgs,
  ...
}: {
  services.tor = {
    enable = true;
    client.enable = true;
  };

  environment.systemPackages = with pkgs; [
    tor-browser-bundle-bin
  ];
}
