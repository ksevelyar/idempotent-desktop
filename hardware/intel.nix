{ config, ... }:
{
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.availableKernelModules = [
    "aesni_intel"
    "cryptd"
  ];
}
