{ pkgs, lib, ... }:
{
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
    };

    fonts = with pkgs;
      [
        dejavu_fonts

        # clearlyU
        # cm_unicode

        # unfree Microsoft fonts
        corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
        vistafonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
        vistafonts-chs # Microsoft YaHei

        # Dev fonts
        (nerdfonts.override { fonts = [ "FiraCode" "Hack" "Inconsolata" ]; })
        cozette
        siji # https://github.com/stark/siji
        # powerline-fonts # Terminus
        # gohufont
        # terminus
        ankacoder
      ];
  };


  environment.systemPackages = with pkgs;
    [
      font-manager
    ];
}
