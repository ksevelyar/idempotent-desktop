# nix build /etc/nixos#nixosConfigurations.live-usb.config.system.build.isoImage    

args@{ config, pkgs, lib, ... }:
{
  isoImage.volumeID = lib.mkForce "id-live";
  isoImage.isoName = lib.mkForce "id-live.iso";

  imports = [
    ../users/live-usb.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/sysctl.nix
    ../sys/fonts.nix

    ../packages/x-common.nix
    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    ../packages/dev.nix
    ../packages/nvim.nix
    ../packages/tmux.nix
    ../packages/pass.nix

    ../hardware/broadcom-wifi.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix

    ../services/x.nix
    ../services/x/picom.nix
    ../services/x/redshift.nix
    ../services/net/wireguard.nix
    ../services/net/openvpn.nix
    ../services/net/sshd.nix
  ];

  networking.hostName = lib.mkForce "id-live";
  networking.networkmanager.enable = true; # nmtui for wi-fi
  networking.wireless.enable = lib.mkForce false;

  nix = {
    binaryCaches = [
      "https://idempotent-desktop.cachix.org"
    ];
    binaryCachePublicKeys = [
      "idempotent-desktop.cachix.org-1:OkWDud90b2/k/k1yIUg1lxZdNRWEvCfv6zSSRQ75lVM="
    ];
  };

  services.xserver = {
    displayManager = {
      autoLogin = { enable = true; user = "mrpoppybutthole"; };
    };
    videoDrivers = [ "nvidia" "nouveau" "amdgpu" "vesa" "modesetting" ];
  };

  services.getty.helpLine = lib.mkForce ''
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
}
