{ pkgs, ... }:
{
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  services.mpd = {
    enable = true;
    musicDirectory = "/data/music"; # https://www.off-the-beat.com/flac-vs-mp3/
    extraConfig = ''
      audio_output {
        type "pulse"
        name "pulse"
        server "127.0.0.1"
      }

      audio_output {
        type "fifo"
        name "visualization"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };

  environment.systemPackages = with pkgs;
    let
      ncmpcpp = pkgs.ncmpcpp.override {
        visualizerSupport = true;
      };
    in
    [
      ncmpcpp # https://cht.sh/ncmpcpp
      mpc-cli

      # fetch metadata
      # https://picard-docs.musicbrainz.org/en/tutorials/acoustid.html
      picard
      flac # metaflac --list (fzf)

      # rename files to `artist - title.flac` from metadata
      kid3 # kid3-cli -c 'fromtag "%{artist} - %{title}" 2' **/*.flac

      # downcase dirs 
      mmv # mmv '*' '#l1'
    ];

  environment.shellAliases = {
    m = "ncmpcpp";
  };
}
