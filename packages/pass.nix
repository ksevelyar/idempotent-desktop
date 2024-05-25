# https://github.com/gopasspw/gopass#features
# https://woile.github.io/gopass-cheat-sheet/
{
  pkgs,
  lib,
  ...
}: {
  programs.gnupg.agent = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      pinentry-curses
      gopass
    ];
  };
}
