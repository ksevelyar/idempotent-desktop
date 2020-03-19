self: super:
let
  unstable = import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz) {};
in
{
  google-play-music-desktop-player = unstable.google-play-music-desktop-player;
}
