# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Squawks private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-pcserial"

RDEPEND="
	chromeos-base/ec-utils
	pcserial? ( chromeos-base/serial-tty )
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	doappid "{777CE760-E315-FF86-2837-D51D10BA7C52}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/wakeup_input_device_names"
	doins "${FILESDIR}/power_supply_full_factor"
	doins "${FILESDIR}/low_battery_shutdown_percent"

	# Battery cut off
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
