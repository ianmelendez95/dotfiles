#!/usr/bin/env bash

hyprctl monitors | grep -q HDMI-2 > /dev/null
export HYPR_MONITOR_CONNECTED="$?"
