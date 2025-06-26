#!/bin/bash

i3status | while :
do
    read line
    POWER=$(~/.config/i3/power_usage.sh)
    echo "${line} | ${POWER}" || exit 1
done
