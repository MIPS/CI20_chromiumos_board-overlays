#!/bin/bash
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script checks the battery level is high enough for shipping. If not,
# it asks for AC power and waits for the battery to charge.
#

IMG_PATH="/usr/share/factory/images"
MAX_LEVEL=60
TTY="/dev/tty1"

get_percentage() {
   power_supply_info 2>/dev/null \
   | awk '/percentage/ && !/display/ {print int($2)}'
}

# Needed by 'power_supply_info'.
mkdir -p /var/lib/power_manager

if [[ $(get_percentage) -gt $MAX_LEVEL ]]; then
  if (ectool battery | grep -q AC_PRESENT); then
    # If WP enabled, unplugging AC is the only way to discharge.
    if (crossystem sw_wpsw_boot?1 wpsw_boot?1); then
      if [ -e "${IMG_PATH}/remove_ac.png" ]; then
        ply-image --clear 0x000000 "${IMG_PATH}/remove_ac.png"
      else
        echo "============================================" >"$TTY"
        echo "========== Unplug AC adapter now. ==========" >"$TTY"
        echo "============================================" >"$TTY"
        echo "" >"$TTY"
      fi
      while (ectool battery | grep -q AC_PRESENT) ; do
        sleep 0.5;
      done
    else
      ectool chargecontrol discharge
    fi
  fi

  if [ -e "${IMG_PATH}/discharging.png" ]; then
    ply-image --clear 0x000000 "${IMG_PATH}/discharging.png"
  else
    echo "============================================" >"$TTY"
    echo "================ Discharging ===============" >"$TTY"
    echo "============================================" >"$TTY"
    echo "" >"$TTY"
  fi

  # Wait for battery to discharge to MAX_LEVEL.
  while [[ $(get_percentage) -gt $MAX_LEVEL ]]; do
    printf "\033[0;0H\033[K" >"$TTY"
    echo -n "Current Battery Level: $(get_percentage)%" >"$TTY"
    sleep 1
  done

  if (ectool battery | grep -q AC_PRESENT); then
    ectool chargecontrol normal
  fi
fi
