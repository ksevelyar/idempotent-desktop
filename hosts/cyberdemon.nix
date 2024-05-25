{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/manya.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/multiboot.nix
    (import ../hardware/power-management.nix {
      pkgs = pkgs;
      battery = "BATT";
    })
    ../hardware/bluetooth.nix
    ../hardware/pulseaudio.nix
    ../hardware/mouse.nix
    ../hardware/ssd.nix
    ../hardware/intel-cpu.nix
    ../hardware/intel-gpu.nix

    ../sys/aliases.nix
    ../sys/nix.nix
    ../sys/scripts.nix
    ../sys/sysctl.nix
    ../sys/tty.nix
    ../sys/fonts.nix
    ../sys/cache.nix

    ../services/journald.nix
    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/x/unclutter.nix
    ../services/databases/postgresql.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/games.nix
    ../packages/neovim.nix
    ../packages/tmux.nix
    ../packages/x-common.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    ../services/net/avahi.nix
    ../services/net/sshd.nix
    ../services/net/openvpn.nix
    ../services/vpn.nix
  ];

  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.plymouth.enable = true;

  networking.firewall.enable = lib.mkForce true;
  networking.networkmanager.enable = true; # run nmtui for wi-fi
  networking.hostName = "cyberdemon";
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp61s0.useDHCP = true;
  networking.wireguard.interfaces = {
    skynet = {
      ips = ["192.168.42.4"];
      privateKeyFile = "/home/manya/wireguard-keys/private";
      peers = [
        {
          publicKey = "dguI+imiz4FYOoxt9D/eN4Chj8wWSNlEjxKuiO9ZaAI=";
          allowedIPs = ["192.168.42.0/24"];
          endpoint = "95.165.99.133:51821";
          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  #vpn
  services.openvpn.servers = {
    uk-shark.autoStart = true;
    de-shark.autoStart = false;
    fr-shark.autoStart = false;
    us-proton.autoStart = false;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/df8dcd09-38bd-4632-8041-8219ebdc5571";
    fsType = "ext4";
    options = ["noatime" "nodiratime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8CCE-4F4F";
    fsType = "vfat";
    options = ["noatime" "nodiratime"];
  };
}
