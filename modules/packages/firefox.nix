{ pkgs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      home.file.".config/tridactyl/tridactylrc".source = ../../home/.config/tridactyl/tridactylrc;
      home.file.".config/tridactyl/themes/base16-rebecca.css".source = ../../home/.config/tridactyl/themes/base16-rebecca.css;

      programs.browserpass.enable = true;
      programs.firefox.enable = true;
      programs.firefox.profiles =
        let
          defaultSettings = {
            "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "browser.startup.homepage" = "https://weekly.nixos.org/";
            "browser.search.region" = "EN";
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
            "permissions.default.desktop-notification" = 2; # disable all notifications requests
            "ui.context_menus.after_mouseup" = true; # fix right mouse click in xmonad
            "svg.context-properties.content.enabled" = true; # allow dark theme for simple tab groups
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # allow to use userChrome.css
            "gfx.xrender.enabled" = true; # fix tearing with smooth scroll
          };
        in
          {
            work = {
              id = 0;
              settings = defaultSettings // {
                "browser.startup.homepage" = "https://weekly.nixos.org/";
              };
              userChrome = builtins.readFile ../../home/.config/firefox/userChrome.css;
            };

            chill = {
              id = 1;
              settings = defaultSettings // {
                "browser.startup.homepage" = "https://reddit.com/";
              };
              userChrome = builtins.readFile ../../home/.config/firefox/userChrome.css;
            };
          };
    };
  };
}
