# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("f64cb1ae77076ad5ec994670f4a83dc561ea80c4" "3a6ec2be5bb4869962ae4793416173bcc9dca831")
CROS_WORKON_TREE=("551b0421516936971b8d833d3a00c94e120e26ef" "feb88bac2d0eee993aeb1898047de8b06e65ab70")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/third_party/coreboot/blobs")
CROS_WORKON_LOCALNAME=("coreboot" "coreboot/3rdparty")
CROS_WORKON_DESTDIR=("${S}" "${S}/3rdparty")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
