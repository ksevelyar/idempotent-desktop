{ pkgs, ... }:
{
  services.xserver.videoDriver = "nvidia";
  environment.systemPackages = [ pkgs.nvtop ];

  hardware = {
    nvidia.modesetting.enable = true;
  };
}
