{ pkgs, lib, ... }:
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

  random-wallpaper = pkgs.writeScriptBin "random-wallpaper" ''
    #!${pkgs.stdenv.shell}
    feh --randomize --bg-fill --no-fehbg ~/wallpapers
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
  services.udisks2.enable = true;
  services.greenclip.enable = true;
  services.gvfs.enable = lib.mkForce false;

  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      touchpad = {
        accelProfile = lib.mkDefault "adaptive";
        disableWhileTyping = true;
        clickMethod = "buttonareas";
        scrollMethod = lib.mkDefault "edge";
        naturalScrolling = false;
      };
    };

    config = ''
      Section "InputClass"
        Identifier "Mouse"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "adaptive"
      EndSection
    '';

    # inspect with xset q
    serverFlagsSection = lib.mkDefault ''
      Option "BlankTime" "120"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';

    displayManager.defaultSession = lib.mkDefault "none+leftwm";
    displayManager.lightdm = {
      enable = true;
      greeters.enso = {
        enable = true;
        blur = false;
        theme = {
          name = "Dracula";
          package = pkgs.dracula-theme;
        };
        iconTheme = {
          name = "ePapirus";
          package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
          name = "Vanilla-DMZ";
          package = pkgs.vanilla-dmz;
        };
      };
    };

    xkb.layout = "us,ru";
    # use Caps Lock to toggle layouts and turn on Caps Look's led for ru layout
    xkb.options = "grp:caps_toggle,grp:alt_shift_toggle,grp_led:caps";
    desktopManager.xterm.enable = false;
  };

  environment.shellAliases = {
    x = "sudo systemctl restart display-manager";
    xs = "sudo systemctl stop display-manager";
  };

  environment.systemPackages = [
    random-wallpaper
    turn-off-display-and-music
    pick-color
    pkgs.imagemagick
  ];
}
