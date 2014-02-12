# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT="2afc970432e64e30b28924224758a837334e6811"
CROS_WORKON_TREE="b23128f091d684c057004cd7c2aca0cf2e23f71b"
CROS_WORKON_PROJECT="chromiumos/third_party/coreboot"
CROS_WORKON_LOCALNAME="coreboot"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

RDEPEND="!sys-boot/chromeos-coreboot"
