{pkgs, ...}: {
  services.xserver.videoDrivers = ["modesetting"];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
  ];
}
