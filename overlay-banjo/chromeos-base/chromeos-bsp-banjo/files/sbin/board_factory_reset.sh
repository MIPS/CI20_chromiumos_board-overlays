#!/bin/sh -e
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#

/usr/sbin/activate_date --clean
# remove the cached vpd log file so that the next reboot will re-generate it
# in /etc/init/vpd-log.conf.
VPD_2_0="/var/log/vpd_2.0.txt"
rm -f $VPD_2_0
sync
sleep 3

/usr/sbin/board_charge_battery.sh

/usr/sbin/battery_cut_off.sh

# Battery cut-off is failed if it returns with 1.
if [ $? -eq 1 ]; then
    echo "Battery cut-off is failed."
fi
exit 1
