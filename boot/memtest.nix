{
  boot.loader = {
    grub = {
      memtest86.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ memtest86plus ];
}
