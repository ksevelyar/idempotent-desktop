{ config, pkgs, lib, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # TLP brings you the benefits of advanced power management for Linux without the need to understand every technical detail.
  services.tlp.enable = true;
}
