# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("cf686269424ea938d6f953d0f76103182eb71297" "a3d70a3d2b5c052db039d097aaffa42008da24b5")
CROS_WORKON_TREE=("8c396ba4ce4356ed5b770e8c1cf67f9892023982" "40263855d5eef64cea1c729e89397d0f4cef4880")
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
