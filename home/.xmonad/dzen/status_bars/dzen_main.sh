#!/bin/bash

# -------------------
# SETTINGS
# -------------------

SLEEP=1

net_down_icon="^i($HOME/.xmonad/dzen/icons/net_down_03.xbm)"
net_up_icon="^i($HOME/.xmonad/dzen/icons/net_up_03.xbm)"

fs_icon="^i($HOME/.xmonad/dzen/icons/diskette.xbm)"

cpu_icon="^i($HOME/.xmonad/dzen/icons/cpu.xbm)"
mem_icon="^i($HOME/.xmonad/dzen/icons/mem.xbm)"

# -------------------
# FUNCTIONS
# -------------------
function wrapper {
if [ $1 -eq 0 ]
then
echo "000"
elif [ ${#1} -ge 3 ]
then
echo "${color_main}$1"
else
echo $(printf "%03d" $1 | sed "s/\(^0\+\)/\1${color_main}/")
fi
                 }

function wrapper_net {
if [ ${#1} -ge 4 ]
then
echo "${color_main}$1"
else
echo $(printf "%04s" $1 | sed "s/ /0/g;s/\(^0\+\)/\1${color_main}/")
fi
                     }

### network speed ###
# Global variables
interface=$(ip addr | awk '/state UP/ {print $2}' | sed 's/.$//')
received_bytes=""
old_received_bytes=""
transmitted_bytes=""
old_transmitted_bytes=""

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
get_bytes()
{
transmitted_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)
received_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
}

get_velocity()
{
    let vel=$1-$2

    if [ $vel -ge 1024 ] && [ $vel -lt 1048576 ] ;
    then
      velKB=$[vel/1024];
      echo "$(wrapper_net $velKB)K";
    elif [ $vel -ge 1048576 ];
    then
      velMB=$(echo "scale=1; $vel/1048576" | bc)
      echo "$(wrapper_net $velMB)M";
    else
      echo "$(wrapper_net $vel) ";
    fi
}

# Gets initial values.
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes

# cpu
PREV_TOTAL=0
PREV_IDLE=0

# ----------------------
# LOOP
# ----------------------
while :; do

# network
get_bytes

vel_recv=$(get_velocity $received_bytes $old_received_bytes)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes)

network_speed_down="${color_sec1}${net_down_icon} ${color_sec2}$vel_recv"
network_speed_up="${color_sec1}${net_up_icon} ${color_sec2}$vel_trans"

old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes

# disk
root_used=$(df /           | grep -Eo '[0-9]+%' | sed s/%//)
data_used=$(df /storage       | grep -Eo '[0-9]+%' | sed s/%//)
storage_used=$(df /trash | grep -Eo '[0-9]+%' | sed s/%//)

root="${color_sec1}${fs_icon} /root ${color_sec2}$(wrapper $root_used)%"
storage="${color_sec1}${fs_icon} /storage ${color_sec2}$(wrapper $data_used)%"
trash="${color_sec1}${fs_icon} /trash ${color_sec2}$(wrapper $storage_used)%"


# cpu
CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
unset CPU[0]                          # Discard the "cpu" prefix.
IDLE=${CPU[4]}                        # Get the idle CPU time.

# Calculate the total CPU time.
TOTAL=0
for VALUE in "${CPU[@]}"; do
  let "TOTAL=$TOTAL+$VALUE"
done

# Calculate the CPU usage since we last checked.
let "DIFF_IDLE=$IDLE-$PREV_IDLE"
let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"

# Remember the total and idle CPU times for the next check.
PREV_TOTAL="$TOTAL"
PREV_IDLE="$IDLE"

cpu="${color_sec1}${cpu_icon} ${color_sec2}$(wrapper ${DIFF_USAGE})%"

# memory
memory_total=$(free -m | awk 'FNR == 2 {print $2}')
memory_used=$(free -m | awk 'FNR == 2 {print $3}')
memory_free_percent=$[$memory_used * 100 / $memory_total]
mem="${color_sec1}${mem_icon} ${color_sec2}$(wrapper ${memory_free_percent})%"

echo "$network_speed_down  $network_speed_up    $root  $data  $storage    $cpu  $mem "

sleep $SLEEP; done
