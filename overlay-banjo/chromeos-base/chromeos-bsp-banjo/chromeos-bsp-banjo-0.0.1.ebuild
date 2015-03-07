# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Banjo bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

RDEPEND="
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
	media-gfx/ply-image
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_install() {
	doappid "{3A837630-D749-4B7A-86C1-DB0ECC07A08B}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Wiping scripts
	doins "${FILESDIR}"/sbin/*.sh

	insinto "usr/share/factory/images"
	doins "${FILESDIR}"/images/*.png
}
