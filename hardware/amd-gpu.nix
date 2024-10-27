{pkgs, ...}: {
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
}
