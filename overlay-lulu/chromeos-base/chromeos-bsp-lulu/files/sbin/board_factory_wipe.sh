#!/bin/sh -e
#
# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

/usr/sbin/activate_date --clean
# make sure the cached vpd log file has been removed so that the the next reboot
# will re-generate it in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync
sleep 3

# this script is called by clobber-state
for WIPE_OPTION in "$@"; do
  if [ "$WIPE_OPTION" = "battery_cut_off" ]; then
    # battery cut-off after factory wipe-out
    /usr/sbin/battery_cut_off.sh
  elif [ "$WIPE_OPTION" = "shutdown" ]; then
    # shutdown after factory wipe-out
    /sbin/shutdown -h now
  elif [ "$WIPE_OPTION" = "reboot" ]; then
    # reboot after factory wipe-out
    /sbin/reboot
  fi
done

# Board wiping is failed if it returns with 1.
if [ $? -eq 1 ]; then
    echo "Board wiping is failed."
fi
exit 1

# reboot after return to clobber-state(default)

