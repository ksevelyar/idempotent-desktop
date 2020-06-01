{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = [ pkgs.travis pkgs.graphviz pkgs.nix-du ];
}
