{ pkgs, ... }:

let
  id-error = pkgs.writeScriptBin "id-error" ''
    #!${pkgs.stdenv.shell}
    echo -e "\n💀\n"
  '';

  id-refresh-channels = pkgs.writeScriptBin "id-refresh-channels" ''
    #!${pkgs.stdenv.shell}
    set -e

    sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable 
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos 
    
    for i in {1..5}; do sudo nix-channel --update && break || id-error; done
    
    sudo nix-channel --list
  '';

  # https://stackoverflow.com/a/22102938
  # Get hex rgb color under mouse cursor, put it into clipboard and create a notification.
  id-pick-color = pkgs.writeScriptBin "id-pick-color" ''
    #!${pkgs.stdenv.shell}
    set -e

    eval $(xdotool getmouselocation --shell)
    IMAGE=`import -window root -depth 8 -crop 1x1+$X+$Y txt:-`
    COLOR=`echo $IMAGE | grep -om1 '#\w\+'`
    echo -n $COLOR | xclip -i -selection CLIPBOARD
    notify-send "Color under mouse cursor: " $COLOR
  '';

  id-build-iso = pkgs.writeScriptBin "id-build-iso" ''
    #!${pkgs.stdenv.shell}
    set -e

    nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb/graphical.nix -o /tmp/live-usb
    du -h /tmp/live-usb/iso/id-live.iso
  '';

  id-write-usb = pkgs.writeScriptBin "id-write-usb" ''
    #!${pkgs.stdenv.shell}
    set -e

    id-build-iso
    sudo dd bs=4M if=/tmp/live-usb/iso/id-live.iso of=/dev/disk/by-label/id-live status=progress oflag=sync

    echo -e "\n💽"
  '';

  id-info = pkgs.writeScriptBin "id-info" ''
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

  id-deploy = pkgs.writeScriptBin "id-deploy" ''
    #!${pkgs.stdenv.shell}
    cd /etc/nixos 

    set -e

    id-refresh-channels
    id-build-iso

    nix-build '<nixpkgs/nixos>' -A vm -I nixos-config=/etc/nixos/configuration.nix --no-out-link | cachix push idempotent-desktop
    nix-du --root /run/current-system/sw/ -s 100MB | tred | dot -Tsvg -Nfontname=Roboto -Efontname=Roboto > nix-store.svg

    id-build-iso
    rclone copy /tmp/live-usb/iso/id-live.iso gdrive:

    echo 🐗
  '';

in
{
  environment.systemPackages = [
    id-error
    id-info
    id-build-iso
    id-write-usb

    id-pick-color
    pkgs.imagemagick

    id-refresh-channels

    id-deploy
    pkgs.rclone
  ];
}
