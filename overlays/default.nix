self: super:
let
  callPackage = super.callPackage;
in
{
  upwork = callPackage ./pkgs/upwork {};
}
