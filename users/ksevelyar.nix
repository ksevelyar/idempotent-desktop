args@{ config, pkgs, lib, ... }:
let
  user = "ksevelyar";
  email = "ksevelyar@gmail.com";
  name = "Sergey Zubkov";
in
{
  imports = [
    (import ./shared.nix (args // { user = user; email = email; name = name; }))
    (import ../services/x/xmonad.nix (args // { user = user; }))
    (import ../packages/firefox.nix (args // { user = user; }))
  ];

  networking.extraHosts =
    ''
      127.0.0.1 dev.lcl
    '';

  systemd.tmpfiles.rules =
    [
      "d /vvv 0700 1000 wheel" # secrets
    ];

  home-manager = {
    users.${user} = {
      home.file.".mbsyncrc".source = ./ksevelyar/.mbsyncrc;
      home.file.".notmuch-config".source = ./ksevelyar/.notmuch-config;
      home.file.".config/msmtp/msmtp/config".source = ./ksevelyar/.config/msmtp/config;
    };
  };
}
