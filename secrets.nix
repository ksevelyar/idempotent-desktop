let
  ksevelyar = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir";
  kh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmOkYJfoonCR5svdQCKgg3UhIcOSMuWlfvgNnjgumz6 kh@pepes";
  users = [ksevelyar kh];

  hk47 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8XPb9wJhtMJF8DL9hR3UGqVUT0Bbt0I1N3Jy1009of root@hk47";
  laundry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzU+zyZ1T46V3ObptsY+dzGCH0sTwzhCfgPDrGTrV/E root@laundry";
  pepes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHHCW+JtAzYa2LjkuWrfmQysLviOt1/gGk9p5wxIEni8 root@pepes";
  systems = [hk47 laundry pepes];
in {
  "secrets/idempotent-desktop.age".publicKeys = users ++ systems;

  "secrets/ksevelyar.age".publicKeys = [ksevelyar hk47];
  "secrets/xray-xhttp.ksevelyar.age".publicKeys = [ksevelyar hk47];
  "secrets/wg-hk47.age".publicKeys = [ksevelyar hk47];
  "secrets/wg-laundry.age".publicKeys = [ksevelyar laundry];

  # kh
  "secrets/xray-xhttp.kh.age".publicKeys = [kh pepes];
}
