# https://www.programmingfonts.org/
{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true; # ls /run/current-system/sw/share/X11/fonts/
    fontconfig = {
      enable = true;
      cache32Bit = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = ["Source Code Pro"];
        sansSerif = ["Roboto"];
        serif = ["Roboto Slab"];
      };
    };

    packages = with pkgs; [
      terminus_font
      source-sans-pro
      roboto
      cozette
      # https://search.nixos.org/packages?channel=unstable&query=nerdfonts+iosevka
      nerd-fonts.iosevka
      nerd-fonts.blex-mono
      nerd-fonts.caskaydia-mono

      siji # https://github.com/stark/siji
      ipafont # display jap symbols like シートベルツ in polybar
      noto-fonts-emoji # emoji
      source-code-pro
    ];
  };

  environment.systemPackages = with pkgs; [font-manager];
}
