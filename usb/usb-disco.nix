{
  disko.devices = {
    disk = {
      main = {
        # disko-install will override this with: --disk main /dev/sdx
        device = "/dev/sdx";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["noatime" "umask=0077"];
                extraArgs = ["-n" "boot-usb"];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = ["noatime"];
                extraArgs = ["-L" "nixos-usb"];
              };
            };
          };
        };
      };
    };
  };
}
