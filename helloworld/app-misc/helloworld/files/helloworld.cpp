// Copyright 2014 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>
#include <string.h>

int main() {
  printf("Hi there !\n");

  char buf[1024];
  while (1) {
    printf("What is your name?\n> ");
    if (!fgets(buf, sizeof(buf), stdin)) {
      printf("I'm sorry Dave, I'm afraid I can't do that\n\n");
      continue;
    }
    char *return_char = strchr(buf, '\n');
    if (return_char) {
      *return_char = '\0';
    }
    printf("Hi %s ! I am a goldfish!\n", buf);
  }
}
