{ lib, ... }:
{
  boot.plymouth.enable = lib.mkDefault true;
}
