#!/bin/sh

# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Find device0 on 3.0.x kernels and iio:device0 on 3.2 kernels.
for DEVICE in /sys/bus/iio/devices/*; do
  [ -e $DEVICE/illuminance0_calibbias ] && break;
done

# Set the light sensor calibration value.
echo 4000 > $DEVICE/illuminance0_calibbias

# tsl2583 also requires an additional granularity setting here
# which needs a power_state transition to take effect.
echo 200 > $DEVICE/illuminance0_integration_time
echo 0 > $DEVICE/power_state
echo 1 > $DEVICE/power_state
