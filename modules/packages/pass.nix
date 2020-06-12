# https://github.com/gopasspw/gopass#features
# https://woile.github.io/gopass-cheat-sheet/
{ pkgs, lib, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # use vanilla pass for import from your password manger
      (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import ]))
      passExtensions.pass-audit
      passExtensions.pass-import
      passExtensions.pass-otp

      gopass
      ripasso-cursive
    ];
  };
}
