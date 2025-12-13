#!/usr/bin/env bash

LOG="/var/log/hyprland-setup-laptop-monitor.log"

echo "Setting up laptop monitor" >> $LOG

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then 
  echo "ERROR: no instance signature" >> $LOG
fi

echo "$HYPRLAND_INSTANCE_SIGNATURE" > /var/log/hyprland_instance_signature

if hyprctl monitors | grep -q HDMI-A-2 > /dev/null; then 
  hyprctl keyword monitor eDP-1,disable
fi
