{
  config,
  ...
}: {
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;

    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDriver = "nvidia";
}
