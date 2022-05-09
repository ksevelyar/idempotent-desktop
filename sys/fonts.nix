# https://www.programmingfonts.org/
{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true; # ls /run/current-system/sw/share/X11/fonts/
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };

    fonts = with pkgs;
      [
        terminus_font
        # Icons for polybar
        siji # https://github.com/stark/siji
        cozette

        noto-fonts-emoji

        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
        # (nerdfonts.override { fonts = [ "Iosevka" "IBMPlexMono" ]; })
        source-sans-pro
        source-code-pro

        roboto
        roboto-slab
        roboto-mono
      ];
  };

  environment.systemPackages = with pkgs;[ font-manager ];
}
