{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultFonts = false;
    enableFontDir = true; # ls /run/current-system/sw/share/X11-fonts
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Terminus" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };

    fonts = with pkgs;
      [
        # dejavu_fonts
        # gyre-fonts # TrueType substitutes for standard PostScript fonts
        # xorg.fontmiscmisc
        # xorg.fontcursormisc
        unifont
        cozette
        fixedsys-excelsior
        noto-fonts-emoji

        # https://www.programmingfonts.org/
        # unfree Microsoft fonts
        corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
        # vistafonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
        # vistafonts-chs # Microsoft YaHei

        # Required for ryanoasis/vim-devicons
        # https://www.programmingfonts.org/
        (nerdfonts.override { fonts = [ "Iosevka" ]; })
        fira-code

        # Required for polybar
        siji # https://github.com/stark/siji

        open-sans
        roboto
        roboto-slab
        roboto-mono
      ];
  };

  environment.systemPackages = with pkgs;[ font-manager ];
}
