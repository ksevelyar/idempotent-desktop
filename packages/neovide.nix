{ stdenv
, callPackage
, makeRustPlatform
, fetchFromGitHub
, IOKit ? null
, makeWrapper
, glib
, gst_all_1
, libsixel
}:

assert stdenv.isDarwin -> IOKit != null;

let
  date = "2020-05-22";
  mozillaOverlay = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "e912ed483e980dfb4666ae0ed17845c4220e5e7c";
    sha256 = "08fvzb8w80bkkabc1iyhzd15f4sm7ra10jn32kfch5klgl0gj3j3";
  };
  mozilla = callPackage "${mozillaOverlay.out}/package-set.nix" {};
  rustNightly = (mozilla.rustChannelOf { inherit date; channel = "nightly"; }).rust;
  rustPlatform = makeRustPlatform {
    cargo = rustNightly;
    rustc = rustNightly;
  };
in
rustPlatform.buildRustPackage rec {
  pname = "neovide";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "Kethku";
    repo = "neovide";
    rev = "v${version}";
    sha256 = "0z28ymz0kr726zjsrksipy7jz7y1kmqlxigyqkh3pyh154b38cis";
  };

  RUSTC_BOOTSTRAP = 1;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    glib
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    libsixel
  ] ++ pkgs.lib.optionals stdenv.isDarwin [ IOKit ];

  cargoSha256 = "18ycj1f310s74gkjz2hh4dqzjb3bnxm683968l1cbxs7gq20jzx6";

  meta = with pkgs.lib; {
    description = "No Nonsense Neovim Client in Rust";
    homepage = https://github.com/Kethku/neovide;
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.unix;
  };
}
