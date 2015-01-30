#!/bin/sh -e
# Copyright 2010 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Alex specific post USB reset wipe script. This will be run after OQC:
#   1. clean the activate date in VPD.
#   2. shut down the machine and disconnect the battery for shipping.

/usr/sbin/activate_date --clean
# remove the cached vpd log file so that the next reboot will re-generate it
# in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync;sync;sync

# You must put this line in the end of file.
/usr/sbin/battery_cut_off.sh
