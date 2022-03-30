{ pkgs, lib, config, ... }:

let
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

    nix build /etc/nixos#nixosConfigurations.live-usb.config.system.build.isoImage
  '';

  id-write-usb = pkgs.writeScriptBin "id-write-usb" ''
    #!${pkgs.stdenv.shell}
    set -e

    cd /tmp
    iso=$(id-build-iso)
    sudo dd bs=4M if=$iso/iso/id-live.iso of=/dev/disk/by-label/id-live status=progress oflag=sync
    # sudo dd bs=4M if=$img/sd-image/id-live-arm.iso.bz2 of=/dev/disk/by-label/id-live status=progress oflag=sync

    echo -e "\n💽\n"
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

  id-random-wallpaper = pkgs.writeScriptBin "id-random-wallpaper" ''
    #!${pkgs.stdenv.shell}
    feh --randomize --bg-fill --no-fehbg ~/Wallpapers  
  '';

  id-tm = pkgs.writeScriptBin "id-tm" ''
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
  environment.systemPackages = lib.mkIf config.services.xserver.enable ([
    id-random-wallpaper

    id-pick-color
    pkgs.imagemagick
  ] ++ [
    id-build-iso
    id-info
    id-tm
    id-write-usb
  ]); 
}
