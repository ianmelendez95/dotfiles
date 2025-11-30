#!/usr/bin/env bash

if hyprctl monitors | grep -q HDMI-A-2 > /dev/null; then 
  hyprctl keyword monitor eDP-1,disable
fi
