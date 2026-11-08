{lib, ...}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.mkDefault {
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

  xdg.desktopEntries.nvim = {
    name = "Neovim";
    exec = "alacritty -e nvim %F";
    terminal = false;
    mimeType = [
      "text/plain"
      "text/markdown"
      "text/x-markdown"
      "text/html"
    ];
    icon = "nvim";
    categories = ["Utility" "TextEditor"];
  };
}
