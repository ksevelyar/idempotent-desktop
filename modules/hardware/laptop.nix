{ config, pkgs, lib, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=85
    STOP_CHARGE_THRESH_BAT0=95
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
  '';
  # Auto-detect the connected display hardware and load the appropriate X11 setup using xrandr
  # services.autorandr.enable = true;

  # TODO: debug
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="power_supply"
  #   ATTR{status}=="Discharging"
  #   ATTR{capacity}=="[0-90]"
  #   RUN+="${pkgs.libnotify}/bin/notify-send 'battery' 'debug'"
  # '';
}
