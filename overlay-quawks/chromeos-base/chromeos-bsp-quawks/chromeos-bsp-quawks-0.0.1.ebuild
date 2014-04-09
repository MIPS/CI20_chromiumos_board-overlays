# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Quawks private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RDEPEND="
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	doappid "{A772AA64-E906-A01E-1DFD-1856870D39EC}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/wakeup_input_device_names"
}
