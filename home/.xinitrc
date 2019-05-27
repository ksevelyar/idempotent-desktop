xsetroot -cursor_name left_ptr
xset s off
xset dpms 3600 3600 3600

setxkbmap -layout "rukbi_en, rukbi_ru" -option "grp:caps_toggle, grp_led:scroll, lv3:ralt_switch" &
xxkb &
xbindkeys

(sleep 10 && ~/.xmonad/dzen/status_checks/checker.sh) &

(greenclip daemon) &
redshift-gtk &

sh ~/.xinitrc_user

exec xmonad
