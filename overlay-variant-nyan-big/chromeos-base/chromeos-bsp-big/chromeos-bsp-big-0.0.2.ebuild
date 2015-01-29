# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Big bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"

DEPEND=""
RDEPEND="
	chromeos-base/ec-utils
"

S=${WORKDIR}

src_install() {
	doappid "{2FC0F0CF-1A55-DF3F-73E6-517389444085}" # nyan-big

	# Install platform-specific config files for power manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_charge_battery.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"

	insinto "/usr/share/factory/images"
	doins "${FILESDIR}/cutoff_failed.png"
	doins "${FILESDIR}/cutting_off.png"
	doins "${FILESDIR}/remove_ac.png"
	doins "${FILESDIR}/battery_input.png"
	doins "${FILESDIR}/go_to_repair.png"
}
