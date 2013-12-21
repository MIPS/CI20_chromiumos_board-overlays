#!/bin/sh

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# In iio/devices, find device0 on 3.0.x kernels and iio:device0 on 3.2 kernels.
# Check for both the old style and new style calibration filename.
FILE=`echo /sys/bus/iio/devices/*/*intensity*_both_calib*`

# Set the light sensor calibration value.
[ -e "$FILE" ] && echo 15000 > $FILE
