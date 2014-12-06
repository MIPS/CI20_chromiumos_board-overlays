#!/bin/bash
#
# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script uses ectool to send command to EC to cut off the battery power.
#

IMG_PATH="/usr/share/factory/images"
TTY="/dev/tty1"

modprobe i2c_dev
if (ectool battery | grep -q AC_PRESENT); then
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
fi

if [ -e "${IMG_PATH}/cutting_off.png" ]; then
  ply-image --clear 0x000000 "${IMG_PATH}/cutting_off.png"
else
  echo "===============================================" >"$TTY"
  echo "==== Cutting off battery. Wait 10 seconds. ====" >"$TTY"
  echo "===============================================" >"$TTY"
fi
ectool batterycutoff
sleep 15

# Couldn't have reached here
if [ -e "${IMG_PATH}/cutoff_failed.png" ]; then
  ply-image --clear 0x000000 "${IMG_PATH}/cutoff_failed.png"
else
  echo "======================================" >"$TTY"
  echo "========== Cut off failed!! ==========" >"$TTY"
  echo "======================================" >"$TTY"
  echo "" >"$TTY"
fi

sleep 1d
exit 1
