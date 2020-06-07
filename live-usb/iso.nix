# https://github.com/ksevelyar/idempotent-desktop/blob/master/docs/live-usb.md
{ config, pkgs, lib, vars, ... }:
let
  # id-install <hostname>
  # id-install hk-47
  id-install = pkgs.writeScriptBin "id-install" ''
    #!${pkgs.stdenv.shell}
    echo -e "\n🤖\n"

    sudo mount /dev/disk/by-label/nixos /mnt
    sudo mount /dev/disk/by-label/boot /mnt/boot/
    echo -e "\n💾"
    lsblk -f
    
    echo
    sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
    
    if [ -z "$1" ]
      then
        nixos-generate-config --root /mnt/etc/nixos
      else
        cd /mnt/etc/nixos && sudo ln -s hosts/$1 configuration.nix
    fi

    sudo chown -R 1000:1000 /etc/nixos/
    sudo ls -lah /etc/nixos/configuration.nix

    sudo nixos-install
  '';
in
{
  environment.systemPackages = [
    id-install
  ];

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
}
