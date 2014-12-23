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
  if [ "$WIPE_OPTION" = "shutdown" ]; then
    # shutdown after factory wipe-out
    /sbin/shutdown -h now
    # It is regarded as shutdown failure that it isn't shut down within 5 mins.
    sleep 5m
    echo "The device isn't shutdown correctly."
    exit 1
  fi
done
# reboot after return to clobber-state(default)
