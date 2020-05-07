{ pkgs, ... }:
{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    #   drivers = [ pkgs.gutenprint pkgs.hplip ];
  };

  environment.systemPackages = with pkgs;
    [
      system-config-printer
    ];
}
