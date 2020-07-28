{ pkgs, ... }:
{
  services.xserver.videoDriver = "nvidia";

  hardware = {
    nvidia.modesetting.enable = true;
  };

  services.picom = {
    backend = "xrender";
  };

  services.xserver = {
    deviceSection = ''
      Option "NoLogo" "1"
    '';

    screenSection = ''
      Option "TripleBuffer" "1"
    '';

    extraConfig = ''
      Section "Extensions"
        Option "Composite" "Enable"
      EndSection
    '';
  };
}
