# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid udev

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="!<chromeos-base/chromeos-bsp-peppy-private-0.0.2"
RDEPEND="${DEPEND}
	chromeos-base/ec-utils
	media-gfx/ply-image
"

S="${WORKDIR}"

src_install() {
	doappid "{E6710DFC-3EC0-42AE-8095-733FDEA6AF18}"

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

	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/battery_stabilized_after_resume_ms"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/low_battery_shutdown_time_s"
	doins "${FILESDIR}/power_supply_full_factor"

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/hdparm.conf"
	doins "${FILESDIR}/runtime-pm.conf"
}
