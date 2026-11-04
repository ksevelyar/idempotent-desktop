# https://github.com/gopasspw/gopass#features
# https://woile.github.io/gopass-cheat-sheet/
{pkgs, ...}: {
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-rofi;
  };

  environment = {
    systemPackages = with pkgs; [
      gopass
    ];
  };
}
