{pkgs, ...}:
{
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  services.mpd = {
    enable = true;
    musicDirectory = "/data/music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "pulse"
        server "127.0.0.1"
      }
    '';
  };

  environment.systemPackages = with pkgs; [
    ncmpcpp
  ];
}