{
  pkgs,
  vars,
  ...
}: {
  services.mongodb = {
    enable = true;
  };
}
