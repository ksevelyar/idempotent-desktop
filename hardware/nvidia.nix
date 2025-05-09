{config, ...}: {
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };

  services.xserver.videoDriver = "nvidia";
  services.picom = {
    backend = "xrender";
  };
}
