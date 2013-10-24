# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("a84f4981299dd94c51c4f9c056b32bac357ae845" "92cbd5d214e0f2f9a3d52db48dcdaaceb57993d4")
CROS_WORKON_TREE=("5a5ac17fac206012c97eed437d01ff6d1d5607c4" "f25471d88379056071aa16aed01368c3f05f5ae8")
CROS_WORKON_PROJECT=("chromiumos/third_party/coreboot" "chromiumos/platform/vboot_reference")
CROS_WORKON_LOCALNAME=("coreboot" "../platform/vboot_reference")
CROS_WORKON_DESTDIR=("${S}" "${S}/vboot_reference")

COREBOOT_BOARD="nyan"
COREBOOT_BOARD_ROOT="google/nyan"
COREBOOT_BUILD_ROOT="builds/nyan"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"
IUSE="fwserial"

DEPEND="dev-embedded/cbootimage"

RDEPEND="chromeos-base/vboot_reference"

src_prepare() {
	if use fwserial; then
		elog "   - enabling firmware serial console"
		echo "CONFIG_CONSOLE_SERIAL=y" >> .config
	fi
}
