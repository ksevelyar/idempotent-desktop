{ config, pkgs, ... }:
{
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=85
    STOP_CHARGE_THRESH_BAT0=95
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
  '';

  services.xserver = {
    libinput = {
      enable = true;
      accelProfile = "flat"; # flat profile for touchpads
      # naturalScrolling = true;
      disableWhileTyping = true;
    };

    # videoDrivers = [ "nouveau" ];
    # videoDrivers = [ "intel" ];
    # synaptics.enable = false; # disable synaptics
  };

  # flat profile for mice
  # config = ''
  #   Section "InputClass"
  #     Identifier     "My mouse"
  #     Driver         "libinput"
  #     MatchIsPointer "on"
  #     Option "AccelProfile" "flat"
  #   EndSection
  # '';

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply"
    ATTR{status}=="Discharging"
    ATTR{capacity}=="[0-20]"
    RUN+="${pkgs.libnotify}/bin/notify-send 'Low Battery' 'HRU'"
  '';
}
