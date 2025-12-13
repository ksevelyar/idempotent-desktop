{pkgs, ...}: {
  services.xserver.videoDrivers = ["amdgpu"];
  services.xserver.deviceSection = ''Option "TearFree" "true"'';

  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.initrd.enable = true;

  services.lact.enable = true;
}
