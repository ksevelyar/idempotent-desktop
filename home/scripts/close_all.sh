#!/bin/sh

for i in $(wmctrl -l | awk '{print $1}')
do
  wmctrl -ic $i
done
