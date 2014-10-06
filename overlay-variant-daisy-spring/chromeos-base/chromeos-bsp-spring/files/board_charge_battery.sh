#!/bin/bash
#
# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script checks the battery level is high enough for shipping. If not,
# it asks for AC power and waits for the battery to charge.
#

IMG_PATH="/usr/share/factory/images"
BATTERY_PATH="/sys/class/power_supply/sbs-6-000b"
MIN_LEVEL=50
TTY="/dev/tty1"

get_percentage() {
  CHARGE_NOW=$(cat "${BATTERY_PATH}"/charge_now)
  CHARGE_FULL=$(cat "${BATTERY_PATH}"/charge_full)
  echo $((100 * ${CHARGE_NOW} / ${CHARGE_FULL}))
}

if [[ $(get_percentage) -le $MIN_LEVEL ]]; then
  # Ask for AC power
  if (ectool powerinfo | grep Device | grep -v -q 0x20010); then
    ply-image --clear 0x000000 "${IMG_PATH}/connect_ac.png"
    while (ectool powerinfo | grep Device | grep -v -q 0x20010) ; do
      sleep 0.5;
    done
  fi

  # Wait for battery to charge to MIN_LEVEL
  ply-image --clear 0x000000 "${IMG_PATH}/charging.png"
  while [[ $(get_percentage) -le $MIN_LEVEL ]]; do
    printf "\033[0;0H\033[K" >"$TTY"
    echo -n "Current Battery Level: $(get_percentage)%" >"$TTY"
    sleep 1
  done
fi
