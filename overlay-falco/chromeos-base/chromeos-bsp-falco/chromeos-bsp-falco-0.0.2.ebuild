# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

S="${WORKDIR}"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	!<chromeos-base/chromeos-bsp-falco-private-0.0.2
	chromeos-base/ec-utils
	media-gfx/ply-image
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{FA5D6766-6B3C-47C8-84DD-6A322C311569}"

	# Battery cut-off
	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
	dosbin "${FILESDIR}/board_charge_battery.sh"

	insinto "/usr/share/factory/images"
	doins "${FILESDIR}/remove_ac.png"
	doins "${FILESDIR}/cutting_off.png"
	doins "${FILESDIR}/cutoff_failed.png"
	doins "${FILESDIR}/charging.png"
	doins "${FILESDIR}/connect_ac.png"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/battery_stabilized_after_resume_ms"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/low_battery_shutdown_time_s"
	doins "${FILESDIR}/min_visible_backlight_level"
	doins "${FILESDIR}/power_supply_full_factor"

	# Install board-specific laptop mode configs.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/hdparm.conf"
	doins "${FILESDIR}/runtime-pm.conf"
}
