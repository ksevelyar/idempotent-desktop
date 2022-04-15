{ user, lastfm_user, listenbrainz_user, config, ... }:
{
  services.mpdscribble = {
    enable = config.services.mpd.enable;
    endpoints = {
      listenbrainz = {
        passwordFile = "/home/${user}/.secrets/listenbrainz";
        username = listenbrainz_user;
      };
      "last.fm" = {
        passwordFile = "/home/${user}/.secrets/lastfm";
        username = lastfm_user;
      };
    };
  };
}
