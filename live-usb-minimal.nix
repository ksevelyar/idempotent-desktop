# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb-minimal.nix -o live-usb
# sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync

{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    ./modules/sys/aliases.nix
    ./modules/sys/scripts.nix
    ./modules/sys/tty.nix
    ./modules/sys/debug.nix
    ./modules/sys/headless.nix

    ./modules/services/common.nix
    # ./modules/services/x.nix

    # ./modules/x/openbox.nix
    # ./modules/x/fonts.nix
    # ./modules/packages/x-common.nix
    # ./modules/packages/x-extra.nix

    ./modules/packages/absolutely-proprietary.nix
    ./modules/packages/common.nix
    # ../modules/packages/dev.nix
    # ../modules/packages/games.nix
    # ./modules/packages/nvim.nix
    # ./modules/packages/tmux.nix

    # ./modules/hardware/bluetooth.nix
    # ./modules/hardware/sound.nix
    # ./modules/hardware/laptop.nix

    ./modules/net/firewall-desktop.nix
    # ../modules/net/wireguard.nix

    # ../modules/vm/hypervisor.nix

    ./users/live-usb.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub.png;
  isoImage.volumeID = lib.mkForce "nixos-mini";
  isoImage.isoName = lib.mkForce "nixos.iso";

  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  # nix.binaryCaches = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

  services.mingetty.helpLine = lib.mkForce ''
    The "root" account has "jkl" password.
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
