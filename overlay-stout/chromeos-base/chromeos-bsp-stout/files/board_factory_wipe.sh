#!/bin/sh -e
# Copyright 2013 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
# Stout specific post factory wipe script.

# this script is called by clobber-state
for WIPE_OPTION in "$@"; do
  if [ "$WIPE_OPTION" = "shutdown" ]; then
    # shutdown after factory wipe-out
    /sbin/shutdown -h now
  fi
done
# reboot after return to clobber-state(default)

