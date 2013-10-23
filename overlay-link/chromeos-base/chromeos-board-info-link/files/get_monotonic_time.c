// Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>
#include <time.h>

// A simple wrapper around clock_gettime() to get monotonic time
int main(int argc, char** argv) {
  struct timespec tp;
  if (clock_gettime(CLOCK_MONOTONIC, &tp) < 0) {
    tp.tv_sec = 0;
    tp.tv_nsec = 0;
  }
  printf("%lld\n", (long long)tp.tv_sec);
  return 0;
}
