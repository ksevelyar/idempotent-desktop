{ pkgs, lib, config, ... }:
let
  # https://stackoverflow.com/a/22102938
  # Get hex rgb color under mouse cursor, put it into clipboard and create a notification.
  pick-color = pkgs.writeScriptBin "pick-color" ''
    #!${pkgs.stdenv.shell}
    set -e

    eval $(xdotool getmouselocation --shell)
    IMAGE=`import -window root -depth 8 -crop 1x1+$X+$Y txt:-`
    COLOR=`echo $IMAGE | grep -om1 '#\w\+'`
    echo -n $COLOR | xclip -i -selection CLIPBOARD
    notify-send "Color under mouse cursor: " $COLOR
  '';

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

  random-wallpaper = pkgs.writeScriptBin "random-wallpaper" ''
    #!${pkgs.stdenv.shell}
    feh --randomize --bg-fill --no-fehbg ~/wallpapers  
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

  turn-off-display-and-music = pkgs.writeScriptBin "turn-off-display-and-music" ''
    #!${pkgs.stdenv.shell}
    set -e
    
    sleep 0.5
    xset dpms force off
    mpc stop
  '';
in
{
  environment.systemPackages = lib.mkIf config.services.xserver.enable ([
    random-wallpaper

    pick-color
    pkgs.imagemagick
  ] ++ [
    build-live-iso

    host-info
    tm
    turn-off-display-and-music
  ]);
}
