{ config, lib, pkgs, ... }:
{
  system.stateVersion = "9000";

  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/ksevelyar.nix

      ../hardware/ssd.nix

      ../sys/aliases.nix
      ../sys/scripts.nix
      ../sys/tty.nix
      ../sys/nix.nix
      ../sys/vars.nix

      ../boot/bios.nix


      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/nvim.nix
      ../packages/tmux.nix
      ../packages/pass.nix

      ../services/journald.nix
      ../services/net/murmur.nix
      # ../services/net/router.nix
      ../services/net/nginx.nix
      ../services/net/wireguard.nix
      ../services/net/nfs.nix
      ../services/net/sshd.nix
    ];



  networking.useDHCP = false;

  networking.interfaces = {
    enp3s0.useDHCP = true;
  };

  networking.firewall = {
    enable = lib.mkForce true;

    interfaces.enp3s0 = {
      allowedTCPPorts = [
        51821
        # NFS
        111 # portmapper
        2049
        20000
        20001
        20002

        # http, https
        80
        443
      ];
      allowedUDPPorts = [
        51821
      ];
    };
  };

  # mkdir -p ~/wireguard-keys && cd ~/wireguard-keys && umask 077
  # wg genkey | tee private | wg pubkey > public
  networking.wireguard.interfaces = {
    skynet = {
      ips = [ "192.168.42.1" ];
      listenPort = 51821;

      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        # ksevelyar 42-52
        ## hk-47 
        {
          publicKey = "Ql36tqX82moc8k5Yx4McF2zxF4QG3jeoXoj8AxSUNRU=";
          allowedIPs = [ "192.168.42.47" ];
        }
        ## laundry 
        {
          publicKey = "ywV4e4436z6mqKCGF2cJdmuYOTeSY2u+GxrZntneNRw=";
          allowedIPs = [ "192.168.42.46" ];
        }
        ## phone
        {
          publicKey = "Z9kuAhDf9i5azQ49VJuSy16ciqDJ0uPhkqkbRykkPSM=";
          allowedIPs = [ "192.168.42.48" ];
        }

        # alesha 110-120
        ## a11dtop
        {
          publicKey = "B3MbJOo+t9Lds4Wms7CF7SPqIM291vSNKCFDVn4eixk=";
          allowedIPs = [ "192.168.42.110" ];
        }
        {
          publicKey = "cLlSJcvND2mIY36vthOBxFUtpUTltiKGghPM/PcNSxI=";
          allowedIPs = [ "192.168.42.114" ];
        }

        # kh 10-20
        ## catch-22
        {
          publicKey = "FcxMzEwr5LM30FWy+etfBU5CQScioa4WJSXv7vulIDk=";
          allowedIPs = [ "192.168.42.10" ];
        }
        ## pepes
        {
          publicKey = "dKznTEMMN4xKXuP8UDo92G14pzwrJNGTISeSXoMcTxQ=";
          allowedIPs = [ "192.168.42.11" ];
        }

        # manya
        ## cyberdemon
        {
          publicKey = "3DUHA0EYOaFVjeemwvqYa3wtbLDAc4wPhrPVnXxsdQ0=";
          allowedIPs = [ "192.168.42.4" ];
        }
        ## phone
        {
          publicKey = "Cf1ZnKsJMTYTZfjU0xV+NJCXeOKvBq1/b2O4553Y+Ac=";
          allowedIPs = [ "192.168.42.5" ];
        }
        ## arachnotron
        {
          publicKey = "XMoxgJ0y+SAFZDKhSWIC0WfrAVOvIbtGrDKfV5SInnI=";
          allowedIPs = [ "192.168.42.6" ];
        }

        # macbook anya
        {
          publicKey = "xrw8dXQlFEt+PuRRZ8uov+6PCpsCW+0nkBk06Erzu0E=";
          allowedIPs = [ "192.168.42.7" ];
        }

        # prism
        {
          publicKey = "FLCkV96NM5ortoqDNiF4eswK1vnLSa04gTnDMmLuaAg=";
          allowedIPs = [ "192.168.42.50" ];
        }
      ];
    };
  };

  services.nginx = {
    virtualHosts."legacy-intelligence.life" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/legacy-intelligence/dist/";
    };

    virtualHosts."preview-project.com" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/preview-project";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "skynet";
  networking.networkmanager.enable = lib.mkForce false;

  boot.loader.grub.splashImage = lib.mkForce ../assets/grub_1024x768.png;
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];

  boot.kernelModules = [ "kvm-intel" "tcp_bbr" ];
  boot.extraModulePackages = [];
  boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    "net.ipv4.ip_forward" = true;
  };

  swapDevices = [];

  # sudo e2label /dev/disk/by-uuid/44b4a02e-1993-4470-b345-b2ca5e3e5b42 nixos
  # sudo e2label /dev/sdb1 storage

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  # fileSystems."/storage" =
  #   {
  #     device = "/dev/disk/by-label/storage";
  #     fsType = "ext4";
  #   };
}
