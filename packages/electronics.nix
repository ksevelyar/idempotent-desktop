{
  config,
  pkgs,
  ...
}: {
  services.udev.packages = [pkgs.stlink];

  environment.systemPackages = with pkgs; [
    fritzing
    librepcb
    # xoscope

    # stm32
    # stlink
    # openocd
    # gcc-arm-embedded
    # stm32cubemx
    # gnumake
  ];
}
