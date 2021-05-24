{ user, pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      home.file.".config/firefox/SwitchyOmega.bak".source = ../users/shared/.config/firefox/SwitchyOmega.bak;

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
            "browser.startup.page" = 3; # restore last session
            "browser.urlbar.suggest.history" = false;
            "devtools.toolbox.host" = "right";
            "general.smoothScroll" = false;
            "print.print_footerleft" = "";
            "print.print_footerright" = "";
            "print.print_headerleft" = "";
            "print.print_headerright" = "";
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
                "browser.startup.homepage" = "https://reddit.com/";
              };
            };
          };
    };
  };
}
