# nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
# sudo dd bs=4M if=live-usb/iso/nixos.iso of=/dev/sdc status=progress && sync

{ config, pkgs, lib, vars, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>

    ./modules/sys/aliases.nix
    ./modules/sys/scripts.nix
    ./modules/sys/tty.nix
    ./modules/sys/debug.nix
    ./modules/sys/vars.nix
    ./modules/sys/sysctl.nix

    ./modules/services/common.nix
    ./modules/services/x.nix

    ./modules/x/xmonad.nix
    ./modules/x/fonts.nix
    ./modules/packages/x-common.nix
    # ./modules/packages/x-extra.nix

    ./modules/packages/absolutely-proprietary.nix
    ./modules/packages/common.nix
    # ./modules/packages/dev.nix
    # ./modules/packages/games.nix
    ./modules/packages/nvim.nix
    ./modules/packages/tmux.nix
    ./modules/packages/firefox.nix

    ./modules/hardware/bluetooth.nix
    ./modules/hardware/sound.nix
    ./modules/hardware/laptop.nix

    ./modules/net/firewall-desktop.nix
    # ./modules/net/wireguard.nix
    # ./modules/net/i2p.nix
    ./modules/net/tor.nix
    ./modules/net/sshd.nix

    # ./modules/vm/hypervisor.nix

    ./users/shared.nix
    ./users/live-usb.nix
  ];

  # isoImage.splashImage = lib.mkForce /etc/nixos/assets/grub_big.png;
  isoImage.volumeID = lib.mkForce "idempotent-desktop";
  isoImage.isoName = lib.mkForce "idempotent-desktop.iso";

  # Whitelist wheel users to do anything
  # This is useful for things like pkexec or gparted
  #
  # WARNING: this is dangerous for systems
  # outside the installation-cd and shouldn't
  # be used anywhere else.
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

  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  services.mingetty.helpLine = lib.mkForce ''
    The "root" account has "jkl" password.
    Type `x' to start the graphical user interface.
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
