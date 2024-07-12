{pkgs, ...}: {
  services.xserver.videoDrivers = ["intel"];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
  ];
}
