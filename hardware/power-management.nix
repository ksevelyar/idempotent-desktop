{
  pkgs,
  ...
}: {
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  environment.systemPackages = with pkgs; [
    powertop
    acpi
  ];
}
