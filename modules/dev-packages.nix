{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    authentication = ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };

  environment.systemPackages = with pkgs;
    [
      # images
      gitg
      imagemagick

      go
      nodejs
      elixir
      gcc
    ];
}
