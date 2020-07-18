# mix archive.install hex phx_new
# mix phx.new hello --no-webpack

with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "elixir-env";
  buildInputs = [
    elixir
    inotify-tools
  ];
}
