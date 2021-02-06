{ pkgs
, stdenv
, fetchurl
, dpkg
, glib
, gdk-pixbuf
, gtk3
, xorg
, libuuid
, ffmpeg
, nss
, pango
, nspr
, at-spi2-atk
, alsaLib
, cairo
, expat
, atk
, cups
, dbus
, gcc
, systemd
}:
let
  version = "5.3.3.862";
  version_hash = "v5_3_3_862_0gofuuatmjqd0n86";
in
stdenv.mkDerivation {
  pname = "upwork";
  version = "${version}";

  src = fetchurl {
    url = "https://updates-desktopapp.upwork.com/binaries/${version_hash}/upwork_${version}_amd64.deb";
    sha256 = "0pplz41kp1l7nyw9kmf0p608p2nx9iy3b0i2dss8pkxmilb3x714";
  };

  # we will use dpkg to unpack package
  buildInputs = [ dpkg ];

  # we will do that manually
  dontUnpack = true;

  libPath = pkgs.lib.makeLibraryPath [
    glib
    gdk-pixbuf
    gtk3
    xorg.libxcb
    libuuid
    ffmpeg
    nss
    pango
    nspr
    at-spi2-atk
    alsaLib
    cairo
    expat
    atk
    cups
    dbus
    gcc
    systemd
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libXScrnSaver
  ];
  installPhase = ''
    dpkg-deb -x $src $out
    # find all shared libraries and executables and patch path to libc and rpaths
    for file in $(find $out -type f \( -perm /0111 -o -name \*.so\* \) ); do
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" "$file" || true
      patchelf --set-rpath $libPath:$out/usr/share/upwork $file || true
    done
    # app.node is shared library, but renamed, so handle it specifically and it
    # requries libstdc++
    patchelf --set-rpath $libPath:${stdenv.cc.cc.lib}/lib:$out/usr/share/upwork $out/usr/share/upwork/app.node
    # nixos expects $out/bin and $out/share to exists
    ln -s $out/usr/bin $out/bin
    ln -s $out/usr/share $out/share
    # replace script's path from /usr/ to $out/usr
    substituteInPlace $out/usr/bin/upwork \
      --replace /usr/share/ $out/usr/share/
  '';

  # we had done that manually
  dontStrip = true;
  dontPatchELF = true;

  meta = {
    homepage = https://upwork.com;
    description = "Time tracking application";
    license = pkgs.lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = [];
  };
}
