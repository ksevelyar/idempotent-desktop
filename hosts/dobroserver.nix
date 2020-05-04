{ config, lib, pkgs, ... }:
{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/aliases.nix
      # FIXME: find replacement for memtest
      ../modules/absolute-proprietary.nix
      ../modules/scripts.nix
      ../modules/boot-legacy.nix

      ../modules/common-packages.nix
      ../modules/ssd.nix
      ../modules/router.nix
      # ../modules/nebula.nix
      # ./modules/extra-packages.nix
      # ./modules/dev-packages.nix
      # ./modules/games.nix
      ../modules/services-headless.nix
      # ./modules/x.nix

      # ./modules/fonts.nix
      # ./modules/fonts-high-dpi.nix
      # ./modules/laptop.nix

      ../users/ksevelyar-headless.nix
    ];

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    skynet = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "192.168.42.1/24" ];

      # The port that Wireguard listens to. Must be accessible by the client.
      listenPort = 51820;

      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        {
          # laundry
          publicKey = "Ql36tqX82moc8k5Yx4McF2zxF4QG3jeoXoj8AxSUNRU=";
          allowedIPs = [ "192.168.42.2/24" ];
        }
        {
          # pepes
          publicKey = "h5oSP9S1wjjPS8bw9/dxh80p+HO0Ia9lkLyAPSvNJXo=";
          allowedIPs = [ "192.168.42.3/24" ];
        }
        {
          # cyberdemon
          publicKey = "hru";
          allowedIPs = [ "192.168.42.4/24" ];
        }
      ];
    };
  };

  # environment.etc."/nebula/lighthouse.crt".source = /storage/nebula/dobroserver.crt;
  # environment.etc."/nebula/lighthouse.key".source = /storage/nebula/dobroserver.key;
  # environment.etc."/nebula/lighthouse.yml".source = /storage/nebula/lighthouse.yml;
  # environment.etc."/nebula/ca.crt".source = /storage/nebula/ca.crt;

  hardware = {
    cpu.intel.updateMicrocode = true;
  };

  networking.hostName = "dobroserver";
  networking.networkmanager.enable = lib.mkForce false;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    # Transmission
    51413
    # VNC
    5900

    # NFS
    111
    2049
    20000
    20001
    20002

    # Dev
    8080
  ];
  networking.firewall.allowedUDPPorts = [ 51413 5900 111 2049 20000 20001 20002 8080 51820 ];


  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  swapDevices = [];
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/44b4a02e-1993-4470-b345-b2ca5e3e5b42";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };
}
