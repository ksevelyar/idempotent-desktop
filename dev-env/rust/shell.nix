with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "rust-dev-env";

  nativeBuildInputs = [
    rustc
    rustup
    cargo
    pkgconfig
  ];

  buildInputs = with pkgs; [
    openssl
    cairo
    glib
  ];
}
