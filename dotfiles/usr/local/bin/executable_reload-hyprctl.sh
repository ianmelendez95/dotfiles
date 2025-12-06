#!/usr/bin/env bash

LOG_FILE=/var/log/reload-hyprctl.log

echo -e "\nReloading Hyprland via script" >> $LOG_FILE
hyprctl reload >> $LOG_FILE 2>&1
echo -e "\nReloaded Hyprland via script" >> $LOG_FILE

