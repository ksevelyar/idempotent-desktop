{pkgs, ...}: {
  systemd.user.timers.random-wallpaper = {
    timerConfig.OnBootSec = "5m";
    timerConfig.OnUnitInactiveSec = "5m";
    timerConfig.Unit = "random-wallpaper.service";
    wantedBy = ["timers.target"];
  };

  systemd.user.services.random-wallpaper = {
    serviceConfig.PassEnvironment = "DISPLAY";
    script = ''
      ${pkgs.feh}/bin/feh --randomize --recursive --bg-fill --no-fehbg ~/wallpapers
    '';
  };
}
