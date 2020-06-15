with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "rust-dev-env";

  nativeBuildInputs = [
    rustc
    cargo
    pkgconfig
  ];

  buildInputs = with pkgs; [
    openssl
    cairo
    gdk_pixbuf
    glib

    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    libsixel
  ];
}
