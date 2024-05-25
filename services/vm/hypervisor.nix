{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
