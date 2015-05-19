#!/bin/bash
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script uses ectool to send command to EC to cut off the battery power.
#

DISPLAY_MESSAGE="/usr/sbin/display_wipe_message.sh"
modprobe i2c_dev

if (ectool battery | grep -q AC_PRESENT); then
  "${DISPLAY_MESSAGE}" "remove_ac"
  while (ectool battery | grep -q AC_PRESENT) ; do
    sleep 0.5;
  done
fi

"${DISPLAY_MESSAGE}" "cutting_off"

ectool batterycutoff at-shutdown
shutdown -h now
sleep 15

"${DISPLAY_MESSAGE}" "cutoff_failed"

sleep 1d
exit 1
