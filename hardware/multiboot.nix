# Dual boot with win10 https://github.com/ksevelyar/carbicide
{pkgs, ...}: {
  boot.loader = {
    grub.useOSProber = true;
  };
  environment.systemPackages = with pkgs; [os-prober];
}
