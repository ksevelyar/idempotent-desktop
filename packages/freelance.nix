{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # hubstaff
    upwork
    # skype
    # teams
  ];
}
