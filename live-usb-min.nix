# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
{ config, pkgs, lib, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    ./modules/sys/aliases.nix
    ./modules/sys/scripts.nix
    ./modules/sys/tty.nix
    ./modules/sys/debug.nix
    ./modules/sys/vars.nix
    ./modules/sys/sysctl.nix

    ./modules/services/common.nix
    # ./modules/services/x.nix

    # ./modules/x/openbox.nix
    # ./modules/x/fonts.nix
    # ./modules/packages/x-common.nix
    # ./modules/packages/x-extra.nix

    ./modules/packages/absolutely-proprietary.nix
    ./modules/packages/common.nix
    # ./modules/packages/dev.nix
    # ./modules/packages/games.nix
    ./modules/packages/nvim.nix
    ./modules/packages/tmux.nix

    # ./modules/hardware/bluetooth.nix
    # ./modules/hardware/sound.nix
    # ./modules/hardware/laptop.nix

    ./modules/net/firewall-desktop.nix
    # ./modules/net/wireguard.nix
    ./modules/net/sshd.nix

    # ./modules/vm/hypervisor.nix

    ./users/live-usb.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  isoImage.volumeID = lib.mkForce "id-live-min";
  isoImage.isoName = lib.mkForce "id-live-min.iso";

  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

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
}
