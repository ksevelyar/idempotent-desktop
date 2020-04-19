# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
# sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync

{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./modules/aliases.nix
    ./modules/scripts.nix
    # ./modules/services.nix
    # ./modules/x.nix
    # ./modules/fonts.nix

    ./modules/common-packages.nix
    # ./modules/extra-packages.nix

    ./users/live-usb.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub.png;
  isoImage.volumeID = lib.mkForce "nixos-mini";
  isoImage.isoName = lib.mkForce "nixos.iso";

  nixpkgs.config.allowUnfree = true;
  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = true;
    pulseaudio.enable = false;
  };
  sound.enable = false;

  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  nix.binaryCaches = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

  services.mingetty.helpLine = lib.mkForce ''
    The "root" account has "jkl" password.

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
