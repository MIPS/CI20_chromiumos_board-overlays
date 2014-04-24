# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Glimmer private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	chromeos-base/chromeos-accelerometer-init
	chromeos-base/chromeos-touch-config-glimmer
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
	media-gfx/ply-image
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	doappid "{D0DBB0D9-6EEB-B148-F8AF-AE8AF86ECE5B}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/min_visible_backlight_level"
	doins "${FILESDIR}/wakeup_input_device_names"

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

	exeinto "/opt/google/touch"
	doexe "${FILESDIR}/touch-control.sh"
}
