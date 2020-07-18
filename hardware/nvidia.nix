{ pkgs, ... }:
{
  services.xserver.videoDriver = "nvidia";
  environment.systemPackages = [ pkgs.nvtop ];

  hardware = {
    nvidia.modesetting.enable = true;
  };

  # fix nvidia tearing
  services.picom = {
    backend = "xrender";
  };
}
