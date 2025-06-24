{
  user,
  pkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      programs.browserpass.enable = true;
      programs.firefox.enable = true;
      programs.firefox.profiles = let
        defaultSettings = {
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.warnOnClose" = false;
          "browser.startup.homepage" = "https://weekly.nixos.org/";
          "browser.urlbar.update1" = false; # don't enlarge URL bar on click
          "browser.urlbar.placeholderName" = "Google";
          "browser.urlbar.placeholderName.private" = "Google";

          "browser.uidensity" = 1; # minimal ui
          "permissions.default.desktop-notification" = 2; # disable all notifications requests
          "ui.context_menus.after_mouseup" = true; # fix right mouse click in tiling wm
          "svg.context-properties.content.enabled" = true; # allow dark theme for simple tab groups
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
      in {
        work = {
          isDefault = true;
          id = 0;
          settings =
            defaultSettings
            // {
              "browser.startup.homepage" = "https://weekly.nixos.org/";
            };
        };

        chill = {
          isDefault = false;
          id = 1;
          settings =
            defaultSettings
            // {
              "browser.startup.homepage" = "https://reddit.com/";
            };
        };
      };
    };
  };
}
