{ lib, ... }:
{
  security.sudo = {
    enable = true;
    # Allow passwordless sudo 
    wheelNeedsPassword = lib.mkForce false;
  };
}
