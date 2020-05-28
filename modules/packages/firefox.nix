{ pkgs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      programs.browserpass.enable = true;
      programs.firefox.enable = true;
      programs.firefox.profiles =
        let
          defaultSettings = {
            "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
            "gfx.xrender.enabled" = true; # fix tearing with smooth scroll
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "browser.startup.homepage" = "https://weekly.nixos.org/";
            "browser.search.region" = "EN";
            # "browser.search.countryCode" = "GB";
            "browser.search.isUS" = true;
            "browser.newtabpage.enabled" = false;
            "browser.bookmarks.showMobileBookmarks" = true;
            "browser.uidensity" = 1;
            "browser.urlbar.update1" = true;
            "distribution.searchplugins.defaultLocale" = "en-US";
            "general.useragent.locale" = "en-US";
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
            "services.sync.declinedEngines" = "passwords";
            "services.sync.engine.passwords" = false;
            "permissions.default.desktop-notification" = 2;
            "ui.context_menus.after_mouseup" = true;
            "svg.context-properties.content.enabled" = true;
          };
        in
          {
            work = {
              id = 0;
              settings = defaultSettings // {
                "browser.startup.homepage" = "https://weekly.nixos.org/";
              };
            };

            chill = {
              id = 1;
              settings = defaultSettings // {
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              };
              userChrome = builtins.readFile ../../home/.config/firefox/userChrome.css;
            };
          };
    };
  };
}
