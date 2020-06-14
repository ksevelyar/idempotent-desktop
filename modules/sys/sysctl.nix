# uname -a to check kernel version
{ pkgs, lib, ... }:
{
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_latest_hardened;
  # boot.kernelPackages = pkgs.linuxPackages_hardened;

  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {

    # Requires >= 4.9 & kernel module
    "net.ipv4.tcp_congestion_control" = "bbr";
    # # Requires >= 4.19
    "net.core.default_qdisc" = "cake";

    # # Disable magic SysRq key
    # "kernel.sysrq" = 0;
    # # Ignore ICMP broadcasts to avoid participating in Smurf attacks
    # "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
    # # Ignore bad ICMP errors
    # "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    # # Reverse-path filter for spoof protection
    # "net.ipv4.conf.default.rp_filter" = 1;
    # "net.ipv4.conf.all.rp_filter" = 1;
    # # SYN flood protection
    # "net.ipv4.tcp_syncookies" = 1;
    # # Do not accept ICMP redirects (prevent MITM attacks)
    # "net.ipv4.conf.all.accept_redirects" = 0;
    # "net.ipv4.conf.default.accept_redirects" = 0;
    # "net.ipv4.conf.all.secure_redirects" = 0;
    # "net.ipv4.conf.default.secure_redirects" = 0;
    # "net.ipv6.conf.all.accept_redirects" = 0;
    # "net.ipv6.conf.default.accept_redirects" = 0;
    # # Do not send ICMP redirects (we are not a router)
    # "net.ipv4.conf.all.send_redirects" = 0;
    # # Do not accept IP source route packets (we are not a router)
    # "net.ipv4.conf.all.accept_source_route" = 0;
    # "net.ipv6.conf.all.accept_source_route" = 0;
    # # Protect against tcp time-wait assassination hazards
    # "net.ipv4.tcp_rfc1337" = 1;
  };
}
