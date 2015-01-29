#!/bin/bash
#
# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script checks the battery level is high enough for shipping. If not,
# it asks for AC power and waits for the battery to charge.
#

IMG_PATH="/usr/share/factory/images"
BATTERY_PATH="/sys/class/power_supply/sbs-5-000b"
MIN_LEVEL=35
TTY="/dev/tty1"

get_percentage() {
  CHARGE_NOW=$(cat "${BATTERY_PATH}"/charge_now)
  CHARGE_FULL=$(cat "${BATTERY_PATH}"/charge_full)
  echo $((100 * ${CHARGE_NOW} / ${CHARGE_FULL}))
}

if [[ $(get_percentage) -le $MIN_LEVEL ]]; then
  # Go to repair station for battery charging to MIN_LEVEL
  ply-image --clear 0x000000 "${IMG_PATH}/go_to_repair.png"
  while [[ $(get_percentage) -le $MIN_LEVEL ]]; do
    printf "\033[0;0H\033[K" >"$TTY"
    echo -n "Current Battery Level: $(get_percentage)%" >"$TTY"
    sleep 1
  done
  ply-image --clear 0x000000
fi
