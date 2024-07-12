{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.xserver.videoDrivers = ["amdgpu"];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
}
