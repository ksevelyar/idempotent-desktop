{ config, pkgs, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  services.pgmanage.enable = false;
  services.postgresql = {
    package = pkgs.postgresql_11;
    enable = true;
    authentication = ''
      local all all trust
      host all all localhost trust
    '';
  };

  # pg admin dep
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.0.2u"
  ];

  environment.systemPackages = with pkgs;
    [
      # api
      curlie

      # vm
      packer
      docker_compose
      docker-machine
      vagrant
      kubernetes
      ansible
      qemu

      # sql
      pgadmin

      # images
      gitg
      imagemagick

      go
      nodejs
      elixir
      inotify-tools
      gcc

      # arduino
      arduino
      arduino-core
      stable.fritzing
      ino
    ];
}
