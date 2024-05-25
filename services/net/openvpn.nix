{pkgs, ...}: {
  environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
  environment.systemPackages = with pkgs; [openvpn];
}
