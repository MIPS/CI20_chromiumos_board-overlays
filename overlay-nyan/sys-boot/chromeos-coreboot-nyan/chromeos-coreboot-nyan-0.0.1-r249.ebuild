# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("f6d95cf4ba6ce1bc0e1df4a0e9f655ad9fea9feb" "435be9873179338d0c4e7b2d823989181a089771")
CROS_WORKON_TREE=("9fc6d94a9275fc307fccb8ccca691a737349463a" "543684777aa560b9204d462d64770c6e209c4083")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
