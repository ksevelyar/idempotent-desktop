# Default apps

## List available apps

```fish
fd desktop /run/current-system/sw/share/applications/ ~/.local/share/applications/ ~/.nix-profile/share/applications/ --exec basename | sort
```

## Set defaults
```nix
  home-manager = {
    users.${user} = {
      xdg.mimeApps = {
        enable = true;

        defaultApplications = {
          "inode/directory" = "nemo.desktop";

          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "text/html" = "firefox.desktop";

          "video/*" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "video/mpeg" = "mpv.desktop";

          "image/*" = "imv-dir.desktop";
          "image/png" = "imv-dir.desktop";
          "image/webp" = "imv-dir.desktop";
          "image/gif" = "imv-dir.desktop";
          "image/jpeg" = "imv-dir.desktop";

          "text/plain" = "nvim.desktop";
          "text/markdown" = "nvim.desktop";
          "text/x-markdown" = "nvim.desktop";
        };
      };
    };
  }
```
