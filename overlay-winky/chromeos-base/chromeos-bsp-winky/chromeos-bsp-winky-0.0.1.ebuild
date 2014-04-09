# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Winky bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

RDEPEND="
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{4B8B5979-526A-48D6-B6EB-D72680471AAD}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/low_battery_shutdown_percent"
}
