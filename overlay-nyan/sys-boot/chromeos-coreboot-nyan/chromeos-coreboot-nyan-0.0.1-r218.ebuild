# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("97737a4e4c2ef71a202e46bd7eaea5d2f10d43e5" "46e00e63805f85c05449ce09cd843a18b76ca665")
CROS_WORKON_TREE=("bb10a5424dc76cf5b6322151c9bb59320a9f065e" "0ca64560b0b658fa4553ebe7430a13942312f133")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
