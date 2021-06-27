{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      # mail & tasks
      isync # sync imap
      msmtp # send mail
      notmuch # index and search mail
      notmuch-bower # notmuch tui
      lynx # bower dep
      mailcap # bower dep
    ];
}
