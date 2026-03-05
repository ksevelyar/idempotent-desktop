{
  pkgs,
  battery,
  ...
}: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  environment.systemPackages = with pkgs; [
    acpi
  ];

  systemd.user.timers.notify-on-low-battery = {
    timerConfig.OnBootSec = "5m";
    timerConfig.OnUnitInactiveSec = "5m";
    timerConfig.Unit = "notify-on-low-battery.service";
    wantedBy = ["timers.target"];
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
