{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../users/ksevelyar.nix
    ../users/root.nix

    ../hardware/efi.nix
    ../hardware/intel-cpu.nix
    ../hardware/ssd.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/nix.nix
    ../sys/cache.nix

    ../packages/common.nix
    ../packages/neovim.nix
    ../packages/tmux.nix
    ../packages/pass.nix

    ../services/journald.nix
    ../services/net/wireguard.nix
    ../services/net/sshd.nix
    ../services/net/avahi.nix
  ];

  systemd.services.sshd.wantedBy = lib.mkForce ["multi-user.target"];
  networking = {
    hostName = "skynet";
    networkmanager.enable = lib.mkForce false;
    useDHCP = false;
    interfaces.eno0.useDHCP = true;

    firewall = {
      enable = lib.mkForce true;

      interfaces.eno0 = {
        allowedTCPPorts = [
          # wireguard
          51821

          # http, https
          80
          443
        ];
        allowedUDPPorts = [
          # wireguard
          51821
        ];
      };
    };
  };

  networking.wireguard.interfaces.skynet = {
    ips = ["192.168.42.1"];
    listenPort = 51821;
    privateKeyFile = "/home/ksevelyar/.secrets/wireguard/private";

    peers = [
      # ksevelyar 42-52
      ## tv
      {
        publicKey = "XlnWVku8KBnHACykwjFL78IDNTBtiwUtwkLFrEyjAiY=";
        allowedIPs = ["192.168.42.42"];
      }
      ## hk-47
      {
        publicKey = "Ql36tqX82moc8k5Yx4McF2zxF4QG3jeoXoj8AxSUNRU=";
        allowedIPs = ["192.168.42.47"];
      }
      ## phone
      {
        publicKey = "Z9kuAhDf9i5azQ49VJuSy16ciqDJ0uPhkqkbRykkPSM=";
        allowedIPs = ["192.168.42.48"];
      }

      # alesha 110-120
      ## a11dtop
      {
        publicKey = "7Gl9PF+4LUsmOzdY07f9j9m8dV4/RSrqCH8+d2yqhQs=";
        allowedIPs = ["192.168.42.119"];
      }

      # kh 10-20
      ## catch-22
      {
        publicKey = "FcxMzEwr5LM30FWy+etfBU5CQScioa4WJSXv7vulIDk=";
        allowedIPs = ["192.168.42.10"];
      }
      ## pepes
      {
        publicKey = "TJPvhSwUdTo07ppYI/o9AhBupHey4mti0cZXxjWMhmk=";
        allowedIPs = ["192.168.42.11"];
      }

      # manya
      ## cyberdemon
      {
        publicKey = "3DUHA0EYOaFVjeemwvqYa3wtbLDAc4wPhrPVnXxsdQ0=";
        allowedIPs = ["192.168.42.4"];
      }
      ## phone
      {
        publicKey = "Cf1ZnKsJMTYTZfjU0xV+NJCXeOKvBq1/b2O4553Y+Ac=";
        allowedIPs = ["192.168.42.5"];
      }
      ## sobanya
      {
        publicKey = "JRIVeD2SXvGF86NrBAur770DADZ9zYO5d7/sCFqjTRM=";
        allowedIPs = ["192.168.42.6"];
      }

      # anya
      ## macbook
      {
        publicKey = "xrw8dXQlFEt+PuRRZ8uov+6PCpsCW+0nkBk06Erzu0E=";
        allowedIPs = ["192.168.42.7"];
      }

      # obstinatekate
      ## prism
      {
        publicKey = "FLCkV96NM5ortoqDNiF4eswK1vnLSa04gTnDMmLuaAg=";
        allowedIPs = ["192.168.42.50"];
      }
      ## bubaleh
      {
        publicKey = "4uOtdM7jlN/JgJIZnz8faCPRoFmBDm1MvPio3woIYCg=";
        allowedIPs = ["192.168.42.51"];
      }
    ];
  };

  # Intel Atom D2700 (F10 for boot menu)
  # DDR2 4GB
  boot.loader.grub.splashImage = lib.mkForce ../assets/wallpapers/fractal.png;
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  boot.kernelModules = ["kvm-intel" "tcp_bbr"];
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.initrd.luks.devices = {
    nixos = {
      device = "/dev/disk/by-label/enc-nixos";
      allowDiscards = true;
    };
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = ["noatime" "nodiratime"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = ["noatime" "nodiratime"];
  };
}
