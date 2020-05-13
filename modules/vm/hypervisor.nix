{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
    # docker.enable = true;
  };
  environment.systemPackages = with pkgs;
    [
      virtmanager
    ];
}
