{ pkgs, ... }:
{
  services.xserver.screenSection = ''
    Option "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  '';
}
