#!/bin/bash
#
# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script checks the battery level is high enough for shipping. If not,
# it asks for AC power and waits for the battery to charge.
#

IMG_PATH="/usr/share/factory/images"
MIN_LEVEL=40
TTY="/dev/tty1"

get_percentage() {
   power_supply_info 2>/dev/null \
   | awk '/percentage/ && !/display/ {print int($2)}'
}

mkdir -p /var/lib/power_manager

if [[ $(get_percentage) -le $MIN_LEVEL ]]; then
  # Ask for AC power
  if [ -z "$(ectool battery | grep AC_PRESENT)" ]; then
    ply-image --clear 0x000000 "${IMG_PATH}/connect_ac.png"
    while [ -z "$(ectool battery | grep AC_PRESENT)" ]; do
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
