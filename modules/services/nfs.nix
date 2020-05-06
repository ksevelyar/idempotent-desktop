# sudo mkdir -p /export
# sipcalc 192.168.0.1/24
{
  fileSystems."/export/tmp" = { device = "/storage/tmp"; options = [ "bind" ]; };
  fileSystems."/export/work" = { device = "/storage/work"; options = [ "bind" ]; };
  fileSystems."/export/vvv" = { device = "/storage/vvv"; options = [ "bind" ]; };

  services.nfs.server = {
    enable = true;
    statdPort = 20000;
    lockdPort = 20001;
    mountdPort = 20002;
    exports = ''
      /export      192.168.42.0/24,192.168.0.0/24(ro,all_squash,insecure,fsid=0,crossmnt)
      /export/tmp  192.168.42.0/24,192.168.0.0/24(rw,nohide,all_squash,insecure)
      /export/work 192.168.42.0/24,192.168.0.0/24(rw,nohide,all_squash,insecure)
      /export/vvv  192.168.0.0/24(rw,nohide,all_squash,insecure)
    '';
  };

  networking.firewall.allowedTCPPorts = [
    111 # portmapper
    2049
    20000
    20001
    20002
  ];
}
