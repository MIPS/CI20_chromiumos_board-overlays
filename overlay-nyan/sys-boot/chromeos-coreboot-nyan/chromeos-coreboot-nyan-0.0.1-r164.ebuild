# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT=("441aa276446141f1b92ed8fb98c9578597487f4d" "8912169231e589b0400debed26f9cedbbe6d9561")
CROS_WORKON_TREE=("6a17ef3976de06b3b4e3eb64b7e723d5d5045f5a" "aad2329c93c5271a679e385b6fa94b7792c56b69")
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
