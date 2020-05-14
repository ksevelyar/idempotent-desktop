{ pkgs, lib, ... }:
{
  fonts = {
    # enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Terminus" ];
        sansSerif = [ "Vegur" ];
        serif = [ "Vegur" ];
      };
    };

    fonts = with pkgs;
      [
        vegur
        # unfree Microsoft fonts
        corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings
        vistafonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
        vistafonts-chs # Microsoft YaHei

        # Required for ryanoasis/vim-devicons
        (nerdfonts.override { fonts = [ "FiraCode" "Hack" "Inconsolata" ]; })

        # Required for polybar
        siji # https://github.com/stark/siji

        dejavu_fonts
        cozette
        ankacoder
      ];
  };

  environment.systemPackages = with pkgs;[ font-manager ];
}
