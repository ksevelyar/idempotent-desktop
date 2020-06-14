{ pkgs, ... }:
{
  services.minecraft-server = {
    enable = true;
    declarative = true;
    eula = true;
    openFirewall = true;
    serverProperties = {
      online-mode = false;
      max-players = 10;
      motd = "🐖";
    };
  };
}
