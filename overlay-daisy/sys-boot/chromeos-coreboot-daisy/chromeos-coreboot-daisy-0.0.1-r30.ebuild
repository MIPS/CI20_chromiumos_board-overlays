# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT="b2c6026d48a452daa25ea73fa791f531811c400a"
CROS_WORKON_TREE="855abeaf4086c5e269a21a427ceff444f0b0558f"
CROS_WORKON_PROJECT="chromiumos/third_party/coreboot"
CROS_WORKON_LOCALNAME="coreboot"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
