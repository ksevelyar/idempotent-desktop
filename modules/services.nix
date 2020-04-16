{ pkgs, ... }:
{
  services.nfs.server.statdPort = 4000;
  services.nfs.server.lockdPort = 4001;
  services.nfs.server.mountdPort = 4002;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    #   drivers = [ pkgs.gutenprint pkgs.hplip ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  services.aria2 = {
    openPorts = true;
  };


  services.mingetty.greetingLine = ''\l'';
  # services.kmscon = {
  #   enable = true;
  #   hwRender = true;
  #   extraConfig = "font-size=14";
  # };

  # Auto-detect the connected display hardware and load the appropriate X11 setup using xrandr
  # services.autorandr.enable = true;

  services.blueman.enable = true;

  services.tor = {
    enable = true;
    client.enable = true;
  };

  services.udisks2.enable = true;
  # services.devmon.enable = true;
  services.greenclip.enable = true;

  services.redshift = {
    enable = true;

    temperature.night = 4000;
    temperature.day = 6500;
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
  # Allow sshd to be started manually through sudo systemctl start sshd
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [];

  services.journald.extraConfig = "SystemMaxUse=500M";

  services.fail2ban = {
    enable = true;
  };

  services.nixosManual.showManual = true;
}
