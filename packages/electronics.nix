{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      stable.fritzing
      librepcb
      xoscope

      platformio
      # arduino
      # arduino --board arduino:avr:nano --port /dev/ttyUSB0 --upload shroom-box.ino
      arduino
      arduino-core

      # esp8266 / 32
      esptool
      # nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A arduino
    ];
}
