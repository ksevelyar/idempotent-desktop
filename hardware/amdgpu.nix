{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot.kernelParams = [ "amd_iommu=pt" "ivrs_ioapic[32]=00:14.0" "iommu=soft" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  # hardware.cpu.amd.updateMicrocode = true;

  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # AMD GPU drivers

  # services.picom = {
  #   backend = "xrender";
  # };
}
