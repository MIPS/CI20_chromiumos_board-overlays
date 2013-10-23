#!/bin/sh

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

TS_DEBUGFS_DELTAS="/sys/kernel/debug/atmel_mxt_ts/2-004a/deltas"
TS_DEBUGFS_OBJECT="/sys/kernel/debug/atmel_mxt_ts/2-004a/object"
TS_SYSFS_ENTRY="/sys/bus/i2c/drivers/atmel_mxt_ts/2-004a/object"

get_delta_value() {
  echo "Raw Delta Value Dump"
  # Force device to scan
  echo "09000083" > $TS_SYSFS_ENTRY
  sleep 0.05
  # Using the deltas sysfs (much faster than reading the object sysfs)
  raw_data=$(od -A n -t u1 $TS_DEBUGFS_DELTAS)
  count=0
  lsb=0
  for v in $raw_data;
  do
    if [ $(($count%2)) -eq 0 ]; then
      # Data comes as LSB, MSB
      lsb=$v
    else
      val=$(($v*256+$lsb))
      # Adjust for negative value
      if [ $val -gt 32768 ]; then
        val=$(($val-65535))
      fi
      # Format print out, 64 numbers per line
      if [ $(($count%128)) -eq 127 ]; then
        printf "%d\n" $val
      else
        printf "%d," $val
      fi
    fi
    count=$(($count+1))
  done
}

get_object_value() {
  echo "Object Value Dump"
  cat $TS_DEBUGFS_OBJECT
}

get_evdev_log() {
  echo "Touchscreen Evdev Dump"
  /opt/google/touchscreen/touchscreen_feedback > /dev/null
  cat /var/log/evdev_input_events.dat
}

get_mosys_eventlog() {
  echo "Mosys eventlog dump"
  /usr/sbin/mosys eventlog list
}

need_delta() {
  local i
  for i in $@; do
    if [ $i = "--nodelta" ]; then
      return 1
    fi
  done
  return 0
}

echo "CommandLine Parameters:" $@
echo "Timestamp:" $(date +"%F.%X.%N")
echo "Timestamp Monotonic:" $(get_monotonic_time)

if need_delta $@; then
  get_delta_value
fi
get_object_value
get_evdev_log
get_mosys_eventlog

return 0
