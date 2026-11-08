{...}: {
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      Homepage.StartPage = "previous-session";
    };
    profiles = let
      defaultSettings = {
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.warnOnClose" = false;
        "browser.startup.homepage" = "https://weekly.nixos.org/";
        "browser.urlbar.update1" = false;
        "browser.urlbar.placeholderName" = "Google";
        "browser.urlbar.placeholderName.private" = "Google";
        "browser.uidensity" = 1;
        "permissions.default.desktop-notification" = 2;
        "ui.context_menus.after_mouseup" = true;
        "svg.context-properties.content.enabled" = true;
        "signon.rememberSignons" = false;
        "browser.startup.page" = 3;
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
}
