let
  ksevelyar = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir";
  users = [ksevelyar];

  hk47 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKCakH5usQzdXGYe7Ea3r5+DJnNstJCIB0B4CKxzecsH";
  systems = [hk47];
in {
  "ksevelyar.age".publicKeys = [ksevelyar hk47];
  "idempotent-desktop.age".publicKeys = users ++ systems;
}
