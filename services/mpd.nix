{ pkgs, user, ... }:
{
  services.mpd.user = user;
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/data/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "pipewire"
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
      ## https://picard-docs.musicbrainz.org/en/tutorials/acoustid.html
      # rename files with picard name script `%artist% - %title%`
      ## https://picard-docs.musicbrainz.org/en/config/options_filerenaming_editor.html
      picard
      flac # metaflac --list (fzf)

      # downcase dirs
      mmv # mmv '*' '#l1'
    ];

  environment.shellAliases = {
    m = "ncmpcpp";
  };
}
