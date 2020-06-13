# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
{ config, pkgs, lib, vars, ... }:
{
  networking.networkmanager.enable = true; # nmcli for wi-fi
  networking.wireless.enable = lib.mkForce false;

  nix = {
    binaryCaches = [
      "https://idempotent-desktop.cachix.org"
    ];
    binaryCachePublicKeys = [
      "idempotent-desktop.cachix.org-1:OkWDud90b2/k/k1yIUg1lxZdNRWEvCfv6zSSRQ75lVM="
    ];
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.xserver = {
    displayManager.lightdm = {
      autoLogin = { enable = true; user = vars.user; };
    };
  };

  services.mingetty.helpLine = lib.mkForce ''
    The "root" account has "id" password.
    Type `i' to print system information.

    .     .       .  .   . .   .   . .    +  .
      .     .  :     .    .. :. .___---------___.
           .  .   .    .  :.:. _".^ .^ ^.  '.. :"-_. .
        .  :       .  .  .:../:            . .^  :.:\.
            .   . :: +. :.:/: .   .    .        . . .:\
     .  :    .     . _ :::/:               .  ^ .  . .:\
      .. . .   . - : :.:./.                        .  .:\
      .      .     . :..|:                    .  .  ^. .:|
        .       . : : ..||        .                . . !:|
      .     . . . ::. ::\(                           . :)/
     .   .     : . : .:.|. ######              .#######::|
      :.. .  :-  : .:  ::|.#######           ..########:|
     .  .  .  ..  .  .. :\ ########          :######## :/
      .        .+ :: : -.:\ ########       . ########.:/
        .  .+   . . . . :.:\. #######       #######..:/
          :: . . . . ::.:..:.\           .   .   ..:/
       .   .   .  .. :  -::::.\.       | |     . .:/
          .  :  .  .  .-:.":.::.\             ..:/
     .      -.   . . . .: .:::.:.\.           .:/
    .   .   .  :      : ....::_:..:\   ___.  :/
       .   .  .   .:. .. .  .: :.:.:\       :/
         +   .   .   : . ::. :.:. .:.|\  .:/|
         .         +   .  .  ...:: ..|  --.:|
    .      . . .   .  .  . ... :..:.."(  ..)"
     .   .       .      :  .   .: ::/  .  .::\
  '';

  systemd.services.id-bootstrap = {
    script = ''
      id-refresh-channels
    '';

    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
  };
}
