{ pkgs, ... }:
{
  boot.loader = {
    grub.useOSProber = true;
  };
  environment.systemPackages = with pkgs;
    [ os-prober ];
}
