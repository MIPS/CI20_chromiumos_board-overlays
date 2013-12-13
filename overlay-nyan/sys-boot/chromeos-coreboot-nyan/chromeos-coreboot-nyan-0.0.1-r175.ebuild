# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("d00f135c93a52ad4dced2edecb74e2dfc54bb2fa" "1aa59b0ea545d571f24a64af71f412fb214e4f82")
CROS_WORKON_TREE=("3d1fac7a6d1acbaebe58aa8507e9653eb541b67d" "85420040088667c4bb25ee7cb41ca18447b6f0fb")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

COREBOOT_BOARD="nyan"
COREBOOT_BOARD_ROOT="google/nyan"
COREBOOT_BUILD_ROOT="builds/nyan"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"
