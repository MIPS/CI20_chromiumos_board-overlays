# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Skate bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

DEPEND=""
RDEPEND="
	!<chromeos-base/chromeos-bsp-skate-private-0.0.1-r18
	chromeos-base/chromeos-touch-config-skate
"

S=${WORKDIR}

src_install() {
	doappid "{9334BFCE-8C16-59D1-9274-AD14AC4EC0DE}"

	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_charge_battery.sh"

	insinto "/usr/share/factory/images"
	doins "${FILESDIR}/remove_ac.png"
	doins "${FILESDIR}/cutting_off.png"
	doins "${FILESDIR}/cutoff_failed.png"
	doins "${FILESDIR}/charging.png"
	doins "${FILESDIR}/connect_ac.png"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*
}
