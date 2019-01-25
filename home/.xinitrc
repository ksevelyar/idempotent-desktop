# g610-led -a 02

xsetroot -cursor_name left_ptr
xset s off
xset dpms 3600 3600 3600

setxkbmap -layout "rukbi_en, rukbi_ru" -option "grp:caps_toggle, grp_led:scroll, lv3:ralt_switch" &
xxkb &


(sleep 2 && google-chrome-stable) &

# (sleep 10 && ~/.xmonad/dzen/status_checks/checker.sh) &
# (sleep 10 && sudo systemctl restart nginx.service) &

(sleep 10 && ssh -D 9009 myuser@188.166.43.83 -f -N) &
(sleep 10 && /bin/bash -lc "cd /code/dat_filter && bundle exec foreman start") &
(greenclip daemon) &
redshift-gtk &
sync_bg &
exec xmonad
