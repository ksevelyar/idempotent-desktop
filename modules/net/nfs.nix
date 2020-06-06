# sudo mkdir -p /export
# sipcalc 192.168.0.1/24
# https://graspingtech.com/mount-nfs-share-windows-10/
{
  fileSystems."/export/learn" = { device = "/storage/learn"; options = [ "bind" ]; };
  fileSystems."/export/work" = { device = "/storage/work"; options = [ "bind" ]; };
  fileSystems."/export/chill" = { device = "/storage/chill"; options = [ "bind" ]; };
  fileSystems."/export/vvv" = { device = "/storage/vvv"; options = [ "bind" ]; };

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

      /export/vvv   192.168.0.0/24(rw,nohide,all_squash,insecure)
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
