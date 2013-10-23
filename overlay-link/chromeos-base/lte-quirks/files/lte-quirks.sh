#! /bin/sh

# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# This clears the persist flag for the LTE modem, and thus forces a power-cycle
# if the modem doesn't respond after autosuspend/resume.  If we don't set
# avoid_reset_quirk, the persist flag is automatically set by the driver.

ltedir=""
for d in /sys/bus/usb/devices/*; do
  idProduct=$(cat "${d}/idProduct")
  idVendor=$(cat "${d}/idVendor")
  if [ "$idProduct" = "9010" -a "$idVendor" = "1410" ]; then
    ltedir="${d}"
  fi
done

if [ -z "$ltedir" ]; then
  logger "lte-quirks: could not find LTE modem"
  exit 0
fi

echo 1 > "$ltedir/avoid_reset_quirk" || \
  logger "lte-quirks: could not set avoid_reset_quirk"
echo 0 > "$ltedir/power/persist" || \
  logger "lte-quirks: could not clear persist flag"
