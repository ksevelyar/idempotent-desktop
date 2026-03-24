{config, ...}: {
  networking.networkmanager = {
    enable = true;

    ensureProfiles = {
      environmentFiles = [config.age.secrets.shared-network-manager.path];

      profiles = {
        wifi1 = {
          connection = {
            id = "$SSID1";
            type = "wifi";
          };

          ipv4.method = "auto";
          ipv6 = {
            addr-gen-mode = "default";
            method = "auto";
          };

          wifi = {
            mode = "infrastructure";
            ssid = "$SSID1";
          };

          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$PASS1";
          };
        };

        wifi2 = {
          connection = {
            id = "$SSID2";
            type = "wifi";
          };

          ipv4.method = "auto";
          ipv6 = {
            addr-gen-mode = "default";
            method = "auto";
          };

          wifi = {
            mode = "infrastructure";
            ssid = "$SSID2";
          };

          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$PASS2";
          };
        };
      };
    };
  };
}
