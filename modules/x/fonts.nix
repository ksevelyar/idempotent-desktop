{ pkgs, lib, ... }:
{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      allowBitmaps = true;
      useEmbeddedBitmaps = true;
      cache32Bit = true;
      # hinting.enable = false;
    };

    fonts = with pkgs;
      [
        dejavu_fonts
        opensans-ttf

        clearlyU
        cm_unicode

        # unfree Microsoft fonts
        corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
        vistafonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
        vistafonts-chs # Microsoft YaHei

        # Dev fonts
        (nerdfonts.override { fonts = [ "Terminus" ]; })
        cozette
        siji # https://github.com/stark/siji
        tamsyn # http://www.fial.com/~scott/tamsyn-font/
        powerline-fonts
        ankacoder
      ];
  };

  environment.systemPackages = with pkgs;
    [
      font-manager
    ];

  console = {
    font = lib.mkDefault "Lat2-Terminus20";
  };
}
