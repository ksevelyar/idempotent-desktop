{pkgs, ...}: {
  systemd.user.services.devmon = {
    description = "devmon automatic device mounting daemon";
    wantedBy = ["default.target"];
    path = [
      pkgs.udevil
      pkgs.procps
      pkgs.udisks
      pkgs.which
    ];

    serviceConfig.ExecStart = "${pkgs.udevil}/bin/devmon --ignore-label nixos-usb --ignore-label boot-usb";
  };

  services.udisks2.enable = true;
}
