#!/bin/sh

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

VPD_CALIBRATION_NAME=als_cal_data

#
# Fetch the value for a VPD entry by name
# Value may be cached by dump_vpd_log
# $1: name of the VPD entry to fetch
#
get_vpd_entry() {
  local output=''
  local vpd_entry_name=$1
  # The VPD output format is:
  #   "als_cal_data"="1.337"
  output=$(dump_vpd_log --full --stdout | \
           sed -n -r -e '/^"'${vpd_entry_name}'"=/s:^[^=]*="([^"]*)".*:\1:p')

  echo "${output}"
}

#
# main
#

# Load cached calibration data.
CACHE_DIR=/var/spool/als
CACHE_FILE=${CACHE_DIR}/cal.data
if [ -e "${CACHE_FILE}" ]; then
  ALS_CAL=$(cat "${CACHE_FILE}")
else
  ALS_CAL=$(get_vpd_entry ${VPD_CALIBRATION_NAME})
  mkdir -p "${CACHE_DIR}"
  echo "${ALS_CAL}" > "${CACHE_FILE}"
fi

# the default value
: ${ALS_CAL:=10}

# In iio/devices, find device0 on 3.0.x kernels and iio:device0 on 3.2 kernels.
# Find the first "calib" file that works.
for FILE in /sys/bus/iio/devices/*/*calib*; do
  # Set the light sensor calibration value.
  echo "${ALS_CAL}" > $FILE && break
done
