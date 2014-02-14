# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("ff962b81f424c840ef171d4287a65ab79b018a28" "3a6ec2be5bb4869962ae4793416173bcc9dca831")
CROS_WORKON_TREE=("a83f970c87577f04e56ce4c01909d36f57028a9d" "feb88bac2d0eee993aeb1898047de8b06e65ab70")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/third_party/coreboot/blobs")
CROS_WORKON_LOCALNAME=("coreboot" "coreboot/3rdparty")
CROS_WORKON_DESTDIR=("${S}" "${S}/3rdparty")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
