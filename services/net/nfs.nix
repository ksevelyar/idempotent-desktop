{
  fileSystems."/export/learn" = { device = "/data/learn"; options = [ "bind" ]; };
  fileSystems."/export/work" = { device = "/data/work"; options = [ "bind" ]; };
  fileSystems."/export/chill" = { device = "/data/chill"; options = [ "bind" ]; };

  services.nfs.server = {
    enable = true;
    statdPort = 20000;
    lockdPort = 20001;
    mountdPort = 20002;
    exports = ''
      /export       192.168.42.0/24(rw,fsid=0,no_subtree_check)    192.168.0.0/24(rw,fsid=0,no_subtree_check)

      /export/learn 192.168.42.0/24(rw,nohide,all_squash,insecure) 192.168.0.0/24(rw,nohide,all_squash,insecure)
      /export/work  192.168.42.0/24(rw,nohide,all_squash,insecure) 192.168.0.0/24(rw,nohide,all_squash,insecure)
      /export/chill 192.168.42.0/24(rw,nohide,all_squash,insecure) 192.168.0.0/24(rw,nohide,all_squash,insecure)
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
