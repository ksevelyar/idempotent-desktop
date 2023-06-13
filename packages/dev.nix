{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # rust
      rust-analyzer

      # elixir
      # mix archive.install hex phx_new
      elixir
      elixir_ls
      gnumake # argon2

      # node
      nodejs_latest

      # tools
      gcc
      openssl
      curlie
      inotify-tools
      gitg
    ];

  environment.shellAliases = {
    mt = "mix test --max-failures=1";
    c = "cargo --quiet";
  };

  networking.firewall.allowedTCPPorts = [
    1234
    1500
    3000
    4000
    8080
    4040
  ];
}
