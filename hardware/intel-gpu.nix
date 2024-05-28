{pkgs, ...}: {
  services.xserver.videoDrivers = ["intel"];

  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
  ];
}
