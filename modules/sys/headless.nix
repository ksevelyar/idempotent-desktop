{ lib, ... }:
{
  environment.noXlibs = lib.mkForce true;
}
