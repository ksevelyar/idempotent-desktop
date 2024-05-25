{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.videoDrivers = ["amdgpu"];

  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
}
