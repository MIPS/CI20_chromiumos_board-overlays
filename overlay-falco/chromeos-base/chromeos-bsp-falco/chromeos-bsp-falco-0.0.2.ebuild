# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

src_install() {
	doappid "{FA5D6766-6B3C-47C8-84DD-6A322C311569}"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/battery_stabilized_after_resume_ms"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/low_battery_shutdown_time_s"
	doins "${FILESDIR}/min_visible_backlight_level"
	doins "${FILESDIR}/power_supply_full_factor"
	doins "${FILESDIR}/wakeup_input_device_names"

	# Install board-specific laptop mode configs.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/hdparm.conf"
	doins "${FILESDIR}/runtime-pm.conf"

	exeinto "/opt/google/touch"
	doexe "${FILESDIR}/touch-control.sh"
}
