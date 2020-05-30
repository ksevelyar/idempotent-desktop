{ pkgs, vars, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${vars.user} = {
      home.file.".config/tridactyl/tridactylrc".source = ../../home/.config/tridactyl/tridactylrc;
      home.file.".config/tridactyl/themes/joker.css".source = ../../home/.config/tridactyl/themes/joker.css;

      programs.browserpass.enable = true;
      programs.firefox.enable = true;
      programs.firefox.profiles =
        let
          defaultSettings = {
            "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "browser.startup.homepage" = "https://weekly.nixos.org/";
            # "browser.search.region" = "EN";
            # "browser.search.isUS" = true;
            # "browser.newtabpage.enabled" = false;
            "browser.urlbar.update1" = false; # don't enlarge URL bar on click
            # "distribution.searchplugins.defaultLocale" = "en-US";
            # "general.useragent.locale" = "en-US";

            # 
            "browser.urlbar.placeholderName" = "Google";
            "browser.urlbar.placeholderName.private" = "Google";

            "browser.uidensity" = 1; # minimal ui
            "permissions.default.desktop-notification" = 2; # disable all notifications requests
            "ui.context_menus.after_mouseup" = true; # fix right mouse click in xmonad
            "svg.context-properties.content.enabled" = true; # allow dark theme for simple tab groups
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # allow to use userChrome.css
            # "gfx.xrender.enabled" = false; # fix tearing with smooth scroll
            "layers.acceleration.force-enabled" = true; # fix wrong geometry in xmonad after restart
            "signon.rememberSignons" = false; # disable built-in password manager
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
