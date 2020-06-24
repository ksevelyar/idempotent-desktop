with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "elixir-env";
  buildInputs = [
    elixir
  ];
}
