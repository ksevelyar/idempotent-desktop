{config, ...}: {
  hardware.cpu.amd.updateMicrocode = true;

  boot.kernelModules = ["kvm-amd"];
  boot.initrd.availableKernelModules = [
    "cryptd"
  ];
}
