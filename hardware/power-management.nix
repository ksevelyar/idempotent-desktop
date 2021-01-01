{ config, pkgs, lib, ... }:
{
  powerManagement = {
    enable = true;
  };

  # TLP brings you the benefits of advanced power management for Linux without the need to understand every technical detail.
  services.tlp = {
    enable = true;
    settings = {
      # Disable too aggressive power-management autosuspend for USB receiver for wireless mouse
      USB_AUTOSUSPEND = 0; 
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      powertop
      acpi
      tlp
    ];
  };
}
