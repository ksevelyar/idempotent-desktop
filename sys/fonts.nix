# https://www.programmingfonts.org/
{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
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

    packages = with pkgs;
      [
        terminus_font
        source-sans-pro
        roboto
        cozette
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
        (nerdfonts.override { fonts = [ "Iosevka" "IBMPlexMono" ]; })

        siji # https://github.com/stark/siji
        ipafont # display jap symbols like シートベルツ in polybar
        noto-fonts-emoji # emoji
        source-code-pro
      ];
  };

  environment.systemPackages = with pkgs;[ font-manager ];
}
