{ config, lib, pkgs, ... }:
{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      ../modules/absolute-proprietary.nix
      ../modules/aliases.nix
      ../modules/scripts.nix
      ../modules/boot.nix
      ../modules/services.nix

      ../modules/common-packages.nix
      ../modules/extra-packages.nix
      ../modules/dev-packages.nix
      ../modules/games.nix

      ../modules/x.nix
      ../modules/bluetooth.nix
      ../modules/sound.nix
      ../modules/firewall-desktop.nix
      ../modules/fonts.nix
      # ../modules/nebula.nix
      ../modules/wireguard.nix
      ../modules/ssd.nix

      ../modules/vm/hypervisor.nix

      # ../modules/laptop.nix
      ../users/ksevelyar.nix
    ];

  # environment.etc."/nebula/node.crt".source = /storage/nebula/laundry.crt;
  # environment.etc."/nebula/node.key".source = /storage/nebula/laundry.key;
  # environment.etc."/nebula/node.yml".source = /storage/nebula/node.yml;
  # environment.etc."/nebula/ca.crt".source = /storage/nebula/ca.crt;

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    skynet = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "192.168.42.2/24" ];

      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/ksevelyar/wireguard-keys/private";

      peers = [
        # For a client configuration, one peer entry for the server will suffice.
        {
          # Public key of the server (not a file path).
          publicKey = "YruKx4tFhi+LfPgkhSp4IeHZD0lszSMxANGvzyJW4jY=";

          # Forward all the traffic via VPN.
          allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Set this to the server IP and port.
          endpoint = "{77.37.166.17:51820}";

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    cpu.intel.updateMicrocode = true;
    nvidia.modesetting.enable = true;
  };

  networking.hostName = "laundry";
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.plymouth.enable = false;

  swapDevices = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/044a758f-4252-4e42-b68c-a87d2345dc4c";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/3A05-EA05";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/storage" =
    {
      device = "/dev/disk/by-uuid/bd7a95b1-0a44-4477-8616-177b95561ad1";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ];
    };

  fileSystems."/srv/storage/" = {
    device = "/storage/tmp";
    options = [ "bind" ];
  };

  fileSystems."/srv/vvv/" = {
    device = "/storage/vvv";
    options = [ "bind" ];
  };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /srv         192.168.0.1/24(ro,all_squash,insecure,fsid=0,crossmnt)
    /srv/storage 192.168.0.1/24(rw,nohide,all_squash,insecure)
    /srv/vvv     192.168.0.1/24(rw,nohide,all_squash,insecure)
  '';

  services.aria2 = {
    downloadDir = "/storage/tmp";
  };

  services.syncthing = {
    enable = true;
    user = "ksevelyar";
    dataDir = "/storage/syncthing";
    openDefaultPorts = true;
  };
}
