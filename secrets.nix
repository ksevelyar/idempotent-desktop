let
  ksevelyar = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir";
  users = [ksevelyar];

  hk47 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8XPb9wJhtMJF8DL9hR3UGqVUT0Bbt0I1N3Jy1009of root@hk47";
  laundry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzU+zyZ1T46V3ObptsY+dzGCH0sTwzhCfgPDrGTrV/E root@laundry";
  systems = [hk47];
in {
  "secrets/idempotent-desktop.age".publicKeys = users ++ systems;

  "secrets/ksevelyar.age".publicKeys = [ksevelyar hk47];
  "secrets/xray-1.ksevelyar.age".publicKeys = [ksevelyar hk47];
  "secrets/xray-2.ksevelyar.age".publicKeys = [ksevelyar hk47];
  "secrets/wg-hk47.age".publicKeys = [ksevelyar hk47];
  "secrets/wg-laundry.age".publicKeys = [ksevelyar laundry];
}
