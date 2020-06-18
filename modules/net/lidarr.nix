{ vars, ... }:
{
  # http://127.0.0.1:9117/UI/Dashboard
  services.jackett = {
    enable = true;
  };

  services.transmission = {
    enable = false;
    settings = {
      download-dir = "/storage/downloads";
      incomplete-dir = "/storage/downloads/.incomplete";
      incomplete-dir-enabled = true;
      rpc-enabled = true;
    };
  };

  # http://localhost:8686/
  services.lidarr = {
    enable = true;
    user = vars.user;
  };
}
