let
  ksevelyar = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrgLo+NfYI06fdY1BamC5o2tNeRlw1ZuPAkyy41w0Ir";
  kh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmOkYJfoonCR5svdQCKgg3UhIcOSMuWlfvgNnjgumz6 kh@pepes";
  kh_rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNXlGGqBaG3wXy235NZcgG1prg6LE4H2Rajno5Srx+9rQ20FL/sXxfqJAYcCxoj1KeUGWxfBhv0P8qlfv9SFatOeZKsGb6uW8n4zEg4vktgboJ//VPrLGRo3V9+7rQ5EqrK5JBUah3K1WJv4rIGAIu2kWAsEmhnHIpazw9EcQdBsLG98dYBSOerXXwepR31fKJM9aDb4G+AiS2bW/zHhDlUFnZPuCEhsK1RcZqeNW6l3pMfxqK/t1U9xXqxBPjKE8xyleTE5NhYBi9IWh28+dkY9PC8Uj7/T3yon3Axvh6gV9wuk58T/4GeQkpCmtnsTgR3tFULHiXrrHCqszLa5QiEe8EowQiQVyX6iYg//EEyE4fejsijGvcDC7o9Vf9MJYBuSPQyXKK3koayK+t0N7i7u1kp0yLU4rCTWXnqEKa6ksBki7s57hmv0+cR1fMTqFctSUwn1x7ozxfUizunZIP3EtJIq1X65nqd83uA3vORTo6cBVG8W8mvunnsG+tkUtkUU7VSmPhi/7DwFx1l46fgd1DmU3CXI/rk6oaPBvGX063xTZZb1dg0lOhRlVmKNZp6ZwfNp1W0GJqQ1rAQWmfGQMPFOuahOJdjXe6OzPavXAPcUw32avP8C895MY8kTMGbaCPtJ7MCCCbWgf0hT4uaDaLQYgIVPi55OTevY8+vQ== kh@laundry";
  kavarkon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUKrA0XuY+OiXWlDctkApwtFhawDpaHQdEXW/5DTmxw kavarkon@baton";
  users = [ksevelyar kh kavarkon];

  # /etc/ssh/ssh_host_ed25519_key.pub
  hk47 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH8XPb9wJhtMJF8DL9hR3UGqVUT0Bbt0I1N3Jy1009of root@hk47";
  laundry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzU+zyZ1T46V3ObptsY+dzGCH0sTwzhCfgPDrGTrV/E root@laundry";
  pepes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHHCW+JtAzYa2LjkuWrfmQysLviOt1/gGk9p5wxIEni8 root@pepes";
  speedDemon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOo37j6LXdgclRzEDzIZSfrf9tgjITe1QixUxSIzFKNc root@speed-demon";
  systems = [hk47 laundry pepes speedDemon];
in {
  # shared
  "secrets/shared/idempotent-desktop.age".publicKeys = users ++ systems;
  "secrets/shared/wifi.age".publicKeys = users ++ systems;

  # ksevelyar
  "secrets/ksevelyar/xray.age".publicKeys = [ksevelyar hk47 laundry];
  "secrets/ksevelyar/wg-hk47.age".publicKeys = [ksevelyar hk47];
  "secrets/ksevelyar/awg-hk47.age".publicKeys = [ksevelyar hk47];
  "secrets/ksevelyar/wg-laundry.age".publicKeys = [ksevelyar laundry];
  "secrets/ksevelyar/environment-variables.age".publicKeys = [ksevelyar hk47];

  # kh
  "secrets/kh/xray-xhttp.age".publicKeys = [kh pepes kh_rsa];

  # kavarkon
  "secrets/kavarkon/xray-xhttp.age".publicKeys = [kavarkon speedDemon];
}
