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
      ../modules/nebula.nix
      ../modules/ssd.nix

      ../modules/vm/hypervisor.nix

      ../modules/laptop.nix
      ../users/kh.nix
    ];

  # environment.etc."/nebula/node.crt".source = /storage/nebula/pepes.crt;
  # environment.etc."/nebula/node.key".source = /storage/nebula/pepes.key;
  # environment.etc."/nebula/node.yml".source = /storage/nebula/node.yml;
  # environment.etc."/nebula/ca.crt".source = /storage/nebula/ca.crt;

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    skynet = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "192.168.42.3/24" ];

      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/kh/wireguard-keys/private";

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


  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/2aeb21b3-e390-4f10-b163-7cf8615dc3bc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F25E-EE97";
      fsType = "vfat";
    };

  swapDevices = [];

  nix.maxJobs = lib.mkDefault 6;

  networking.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = true;

  networking.hostName = "pepes";

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
  services.xserver.videoDrivers = [ "intel" ];

  console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  # services.xserver.dpi = 180;
  # environment.variables = {
  #   GDK_SCALE = "2";
  #   GDK_DPI_SCALE = "0.5";
  #   _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  # };
}
