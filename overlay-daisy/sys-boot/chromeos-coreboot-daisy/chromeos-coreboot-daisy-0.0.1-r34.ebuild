# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("687f3771fb3e6b340a818fa7594b3ac0630fdeaf" "3a6ec2be5bb4869962ae4793416173bcc9dca831")
CROS_WORKON_TREE=("30c0c5139d51b7447390636fff75a033d9b5e445" "feb88bac2d0eee993aeb1898047de8b06e65ab70")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/third_party/coreboot/blobs")
CROS_WORKON_LOCALNAME=("coreboot" "coreboot/3rdparty")
CROS_WORKON_DESTDIR=("${S}" "${S}/3rdparty")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
