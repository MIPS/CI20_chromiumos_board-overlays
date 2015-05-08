#!/bin/bash -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
"$DIR/make-nand-image.sh" /build/ci20/boot /build/ci20/boot/vmlinuz "$DIR/nand-env.txt" \
  "$HOME/trunk/src/build/images/ci20/latest/nand-flash.img"
