{ pkgs, lib, config, ... }:
let
  build-live-iso = pkgs.writeScriptBin "build-live-iso" ''
    #!${pkgs.stdenv.shell}
    set -e

    cd /tmp
    nix build /etc/nixos#nixosConfigurations.live-usb.config.system.build.isoImage
  '';

  host-info = pkgs.writeScriptBin "host-info" ''
    #!${pkgs.stdenv.shell}

    LOCAL_IP=$(ip -o addr show | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $4}' | cut -d'/' -f 1)
    PUBLIC_IP=$(curl -s ifconfig.me)
    CPU=$(sudo lshw -short | grep -i processor | sed 's/\s\s*/ /g' | cut -d' ' -f3-)
    VIDEO=$(sudo lspci | grep -i --color 'vga\|3d\|2d' | cut -d' ' -f2-)

    echo -e "local: $LOCAL_IP, public: $PUBLIC_IP\n"
    echo -e "Processor: $CPU"
    echo -e "Video: $VIDEO\n"

    echo -e "\n"
    lsblk -f
    
    echo -e "\n"
    lsmod | rg kvm
  '';

  tm = pkgs.writeScriptBin "tm" ''
    #!${pkgs.stdenv.shell}
    set -e

     if [ -z "$1" ]
      then
        tmux new -A -s 🦙
      else
        tmux new -A -s $1
    fi
  '';
in
{
  environment.systemPackages = [
    build-live-iso
    host-info
    tm
  ];
}
