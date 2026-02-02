{lib, ...}: {
  systemd.services.sshd.wantedBy = lib.mkForce []; # sudo systemctl start sshd

  services.openssh = {
    enable = true;
    extraConfig = ''
      permitRootLogin = no
    '';
  };
}
