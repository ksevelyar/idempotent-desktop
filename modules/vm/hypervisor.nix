{ pkgs, ... }:
{
  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
  };
  environment.systemPackages = with pkgs;
    [
      virtmanager
    ];
}
