#!/bin/bash

# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

if [[ ${FLAGS_bootcache_use_board_default} -eq ${FLAGS_TRUE} ]]; then
  FLAGS_enable_bootcache=${FLAGS_TRUE}
fi
