{ pkgs, lib, ... }:
{
  hardware = {
    nvidia.modesetting.enable = true;
  };

  services.picom = {
    backend = "xrender";
  };

  services.xserver = {
    videoDriver = "nvidia";

    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
  };
}
