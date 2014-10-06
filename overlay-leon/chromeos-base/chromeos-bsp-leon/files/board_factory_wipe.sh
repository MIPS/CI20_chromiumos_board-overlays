#!/bin/sh -e
#
# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

# make sure the cached vpd log file has been removed so that the the next reboot
# will re-generate it in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync
sleep 3

# this script is called by clobber-state
# The WIPE_OPTION is defined from the factory test image by writing one of
# battery_cut_off/shutdown/reboot(reboot is a default)
# at /mnt/stateful_partition/factory_wipe_option.
for WIPE_OPTION in "$@"; do
  if [ "$WIPE_OPTION" = "battery_cut_off" ]; then
    # battery cut-off after factory wipe-out
    /usr/sbin/battery_cut_off.sh
  elif [ "$WIPE_OPTION" = "shutdown" ]; then
    # This script show a prompt to tell OP press space key to poweroff.
    /usr/sbin/board_poweroff.sh
  fi
done

# Board power-off is failed if it returns with 1.
if [ $? -eq 1 ]; then
    echo "Board power-off is failed."
fi
exit 1

# reboot after return to clobber-state(default)
