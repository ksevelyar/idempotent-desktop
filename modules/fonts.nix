{ pkgs, ... }:
{

  # Enable the X11 windowing system.
  fonts = {
    fontconfig.allowBitmaps = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;


    fonts = with pkgs;
      [
        # Noto fonts provide basic glyph coverage
        (nerdfonts.override { withFont = "Terminus"; })
        dejavu_fonts

        # unfree Microsoft fonts
        corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
        vistafonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
        vistafonts-chs # Microsoft YaHei

        # Dev fonts
        siji # https://github.com/stark/siji
        tamsyn # http://www.fial.com/~scott/tamsyn-font/
        opensans-ttf
        powerline-fonts
        ankacoder
      ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  i18n.defaultLocale = "en_US.UTF-8";
}
