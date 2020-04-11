{ pkgs, ... }:
{

  # Enable the X11 windowing system.
  fonts = {
    fontconfig.allowBitmaps = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      # Noto fonts provide basic glyph coverage
      dejavu_fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      noto-fonts-cjk

      # unfree Microsoft fonts
      corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
      vistafonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
      vistafonts-chs # Microsoft YaHei

      # Dev fonts
      siji # https://github.com/stark/siji
      tamsyn # http://www.fial.com/~scott/tamsyn-font/
      opensans-ttf
      nerdfonts
      # terminus-nerdfont
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
