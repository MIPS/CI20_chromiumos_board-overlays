#!/bin/sh

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# In iio/devices, find device0 on 3.0.x kernels and iio:device0 on 3.2 kernels.
for FILE in /sys/bus/iio/devices/*/in_illuminance0_calibscale; do
  # Set the light sensor calibration value.
  echo 5.102040 > $FILE && break;
done

for FILE in /sys/bus/iio/devices/*/in_illuminance1_calibscale; do
  # Set the IR compensation calibration value.
  echo 0.053425 > $FILE && break;
done

for FILE in /sys/bus/iio/devices/*/range; do
  # Set the light sensor range value (max lux)
  echo 16000 > $FILE && break;
done

for FILE in /sys/bus/iio/devices/*/continuous; do
  # Change the measurement mode to the continuous mode
  echo als > $FILE && break;
done
