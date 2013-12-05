# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("e47b6a609b9d23694a466b56960d9d14ca5d6242" "a3d70a3d2b5c052db039d097aaffa42008da24b5")
CROS_WORKON_TREE=("b6aa49e6121a0b2b6e615651960306225e4a1c17" "40263855d5eef64cea1c729e89397d0f4cef4880")
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
