{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  programs.virt-manager.enable = true;
}
