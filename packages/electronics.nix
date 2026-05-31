{
  pkgs,
  ...
}: {
  services.udev.extraRules = ''
    # microbit v2
    ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="660", GROUP="dialout"

    # STMicroelectronics ST-LINK/V2
    ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="660", GROUP="dialout"
    # esp32
    SUBSYSTEM=="usb", ATTR{idVendor}=="303a", ATTR{idProduct}=="1001", MODE="0660", GROUP="dialout"
  '';
  environment.systemPackages = with pkgs; [
    # FIXME: 26.05
    # librepcb
    # kicad
  ];
}
