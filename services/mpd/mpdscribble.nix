{
  user,
  listenbrainz_user,
  config,
  ...
}: {
  services.mpdscribble = {
    enable = config.services.mpd.enable;
    endpoints = {
      listenbrainz = {
        passwordFile = "/home/${user}/.secrets/listenbrainz";
        username = listenbrainz_user;
      };
    };
  };
}
