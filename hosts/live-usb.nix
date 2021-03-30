{ config, pkgs, lib, vars, ... }:
{
  vars.battery = "BAT0";
  # isoImage.volumeID = lib.mkForce "id-live";
  # isoImage.isoName = lib.mkForce "id-live.iso";

  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>

    ../users/shared.nix
    ../users/live-usb.nix

    ../sys/aliases.nix
    ../sys/scripts.nix
    ../sys/tty.nix
    ../sys/debug.nix
    ../sys/vars.nix
    ../sys/sysctl.nix
    ../sys/fonts.nix


    ../services/x.nix

    ../services/x/xmonad.nix
    ../packages/x-common.nix

    ../packages/absolutely-proprietary.nix
    ../packages/common.nix
    # ../packages/dev.nix
    # ../packages/games.nix
    ../packages/nvim.nix
    ../packages/tmux.nix
    ../packages/firefox.nix
    ../packages/pass.nix

    ../hardware/broadcom-wifi.nix
    ../hardware/bluetooth.nix
    ../hardware/sound.nix
    ../hardware/power-management.nix

    ../services/net/firewall-desktop.nix
    ../services/net/wireguard.nix
    # ../services/net/i2pd.nix
    # ../services/net/i2p.nix
    ../services/net/tor.nix
    ../services/net/sshd.nix

    #../services/vm/hypervisor.nix
  ];

  networking.hostName = lib.mkForce "live-usb";
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
    displayManager = {
      autoLogin = { enable = true; user = vars.user; };
    };
    videoDrivers = [ "nvidia" "amdgpu" "vesa" "modesetting" ];
  };

  services.getty.helpLine = lib.mkForce ''
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
