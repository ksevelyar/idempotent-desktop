{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      onlyoffice-desktopeditors
    ];
  };
}
