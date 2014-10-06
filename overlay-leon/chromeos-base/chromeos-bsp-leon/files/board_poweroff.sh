#!/bin/bash
#
# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script poweroff this unit.
#

IMG_PATH="/usr/share/factory/images"
TTY="/dev/tty1"
# Remove Space in IFS temporary, because we need Space as a key to trigger
OLDIFS=$IFS
IFS=$'\t\n'

modprobe i2c_dev
if (ectool battery | grep AC_PRESENT); then
  if [ -e "${IMG_PATH}/remove_ac.png" ]; then
    ply-image --clear 0x000000 "${IMG_PATH}/remove_ac.png"
  else
    echo "============================================" >"$TTY"
    echo "========== Unplug AC adapter now. ==========" >"$TTY"
    echo "============================================" >"$TTY"
    echo "" >"$TTY"
  fi
  while (ectool battery | grep AC_PRESENT) ; do
    sleep 0.5;
  done
fi

if [ -e "${IMG_PATH}/press_space_to_poweroff.png" ]; then
  ply-image --clear 0x000000 "${IMG_PATH}/press_space_to_poweroff.png"
else
  echo "===============================================" >"$TTY"
  echo "======= Press space key to power-off. =========" >"$TTY"
  echo "===============================================" >"$TTY"
  echo "" >"$TTY"
fi
until [ "$PRESS_KEY" == " " ]
do
  echo "Press space key to power-off" >"$TTY"
  read -n 1 -s PRESS_KEY <"$TTY"
done
# Set IFS back
IFS=$OLDIFS

if [ -e "${IMG_PATH}/powering_off.png" ]; then
  ply-image --clear 0x000000 "${IMG_PATH}/powering_off.png"
else
  echo "=======================================" >"$TTY"
  echo "==== Powering off. Wait 3 seconds. ====" >"$TTY"
  echo "=======================================" >"$TTY"
fi
poweroff
sleep 15

# Couldn't have reached here
if [ -e "${IMG_PATH}/poweroff_failed.png" ]; then
  ply-image --clear 0x000000 "${IMG_PATH}/poweroff_failed.png"
else
  echo "======================================" >"$TTY"
  echo "========= Power off failed!!==========" >"$TTY"
  echo "======================================" >"$TTY"
  echo "" >"$TTY"
fi

sleep 1d
exit 1
