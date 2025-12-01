#!/usr/bin/env bash

LOG="$HOME/.config/hypr/bin/toggle-laptop-monitor.log"

echo -e "\n--- START ---\n" >> $LOG
hyprctl monitors | grep 'Monitor' 2>&1 >> $LOG
echo "STATUS: $?" >> $LOG
echo -e "\n--- END ---\n" >> $LOG

if hyprctl monitors | grep -q eDP-1 > /dev/null; then 
  hyprctl keyword monitor "eDP-1,disable"
else 
  hyprctl keyword monitor "eDP-1,preferred,auto,1"
fi
