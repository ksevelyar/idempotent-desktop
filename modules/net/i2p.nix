# http://127.0.0.1:7070
# http://127.0.0.1:4444
# http://identiguy.i2p/

{
  # java? Nope.
  # services.i2p.enable = true; 

  # c++
  services.i2pd = {
    enable = true;
    bandwidth = 2500; # kb/s
    proto.http.enable = true;
    proto.httpProxy.enable = true;

    logLevel = "error";

    addressbook.subscriptions = [
      "http://identiguy.i2p/hosts.txt"
      "http://inr.i2p/export/alive-hosts.txt"
      "http://i2p-projekt.i2p/hosts.txt"
      "http://stats.i2p/cgi-bin/newhosts.txt"
    ];
  };

  networking.firewall.allowedUDPPorts = [
    11786
  ];

  networking.firewall.allowedTCPPorts = [
    11786
  ];
}
