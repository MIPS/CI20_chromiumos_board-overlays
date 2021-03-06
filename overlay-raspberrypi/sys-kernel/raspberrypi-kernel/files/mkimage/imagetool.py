#!/usr/bin/env python2

import os
import re
import sys

if len(sys.argv) < 3:
  print("usage : imagetool.py <kernel image> <output file>");
  sys.exit(0)

kernel_image = sys.argv[1]
output_file = sys.argv[2]

re_line = re.compile(r"0x(?P<value>[0-9a-f]{8})")

mem = [0 for i in range(32768)]

def load_to_mem(name, addr):
   f = open(name)

   for l in f.readlines():
      m = re_line.match(l)

      if m:
         value = int(m.group("value"), 16)

         for i in range(4):
            mem[addr] = int(value >> i * 8 & 0xff)
            addr += 1

   f.close()

load_to_mem(os.path.join(os.path.dirname(__file__), "boot-uncompressed.txt"),
            0x00000000)
load_to_mem(os.path.join(os.path.dirname(__file__), "args-uncompressed.txt"),
            0x00000100)

f = open("first32k.bin", "wb")

for m in mem:
   f.write(chr(m))

f.close()

os.system("cat first32k.bin " + kernel_image + " > " + output_file)
