{config, ...}: {
  boot.kernelModules = ["kvm-intel"];
  boot.kernelParams = ["nosgx"];
  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.availableKernelModules = [
    "aesni_intel"
    "cryptd"
  ];
}
