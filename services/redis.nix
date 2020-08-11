{ pkgs, vars, ... }:
{
  services.redis = {
    enable = true;
  };
}
