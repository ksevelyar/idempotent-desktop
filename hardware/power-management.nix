{ pkgs, battery, ... }:
{
  powerManagement.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      # Disable too aggressive power-management autosuspend for USB receiver for wireless mouse
      USB_AUTOSUSPEND = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  environment.systemPackages = with pkgs; [
    powertop
    acpi
    tlp
  ];

  systemd.user.timers.notify-on-low-battery = {
    timerConfig.OnBootSec = "2m";
    timerConfig.OnUnitInactiveSec = "2m";
    timerConfig.Unit = "notify-on-low-battery.service";
    wantedBy = [ "timers.target" ];
  };

  systemd.user.services.notify-on-low-battery = {
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      export battery_capacity=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${battery}/capacity)
      export battery_status=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/${battery}/status)

      if [[ $battery_capacity -le 10 && $battery_status = "Discharging" ]]; then
        ${pkgs.libnotify}/bin/notify-send --urgency=critical "$battery_capacity%: See you, space cowboy..."
      fi
    '';
  };
}
