# https://www.programmingfonts.org/
{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true; # ls /run/current-system/sw/share/X11-fonts
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
        terminus_font
        unifont
        cozette
        fixedsys-excelsior
        noto-fonts-emoji

        # unfree Microsoft fonts
        corefonts # Andale Mono, Arial, Comic Sans, Courier New, Georgia, Impact, Times New Roman, Trebuchet, Verdana, Webdings

        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
        (nerdfonts.override { fonts = [ "Iosevka" "IBMPlexMono" ]; })
        fira-code

        # Icons for polybar
        siji # https://github.com/stark/siji

        open-sans
        roboto
        roboto-slab
        roboto-mono
      ];
  };

  environment.systemPackages = with pkgs;[ font-manager ];
}
