#!/bin/bash
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script checks the battery level is high enough for shipping. If not,
# it asks for AC power and waits for the battery to charge.
#

MAX_LEVEL=60
DISPLAY_MESSAGE="/usr/sbin/display_wipe_message.sh"

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
      "${DISPLAY_MESSAGE}" "remove_ac"
      while (ectool battery | grep -q AC_PRESENT) ; do
        sleep 0.5;
      done
    else
      ectool chargecontrol discharge
    fi
  fi

  # Wait for battery to discharge to MAX_LEVEL.
  while [[ $(get_percentage) -gt $MAX_LEVEL ]]; do
    "${DISPLAY_MESSAGE}" "discharging" "$(get_percentage)" "${MAX_LEVEL}"
    sleep 1
  done

  if (ectool battery | grep -q AC_PRESENT); then
    ectool chargecontrol normal
  fi
fi
