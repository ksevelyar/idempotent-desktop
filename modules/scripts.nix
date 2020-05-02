{
  environment.etc."/scripts/system-info.sh".text = ''
    LOCAL_IP=$(ip -o addr show | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $4}' | cut -d'/' -f 1)
    PUBLIC_IP=$(curl -s ifconfig.me)
    CPU=$(sudo lshw -short | grep -i processor | sed 's/\s\s*/ /g' | cut -d' ' -f3-)
    VIDEO=$(sudo lspci | grep -i --color 'vga\|3d\|2d' | cut -d' ' -f2-)

    sudo nmcli device status
    echo -e "local: $LOCAL_IP, public: $PUBLIC_IP\n"
    echo -e "Processor: $CPU"
    echo -e "Video: $VIDEO\n"

    lsblk -f
  '';

  environment.etc."/scripts/refresh-channels.sh".text = ''
    sudo nix-channel --add https://nixos.org/channels/nixos-20.03 stable 
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos 
    sudo nix-channel --update 
    sudo nix-channel --list
  '';

  # https://stackoverflow.com/a/22102938
  environment.etc."/scripts/pick-color.sh".text = ''
    # Get hex rgb color under mouse cursor, put it into clipboard and create a
    # notification.

    eval $(xdotool getmouselocation --shell)
    IMAGE=`import -window root -depth 8 -crop 1x1+$X+$Y txt:-`
    COLOR=`echo $IMAGE | grep -om1 '#\w\+'`
    echo -n $COLOR | xclip -i -selection CLIPBOARD
    notify-send "Color under mouse cursor: " $COLOR
  '';
}
