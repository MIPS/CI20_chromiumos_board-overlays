# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid toolchain-funcs udev

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="!chromeos-base/light-sensor"
# modemmanager provides Y3300 support.
RDEPEND="${DEPEND}
	sys-apps/iotools
	virtual/modemmanager
"

S=${WORKDIR}

src_install() {
	doappid "{A854E62E-9CB3-4DBE-8BBE-88C48FD65787}"
	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"

	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/runtime-pm.conf"
	doins "${FILESDIR}/intel-hda-powersave.conf"

	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/wakeup_input_device_names"

	exeinto "/opt/google/touch"
	doexe "${FILESDIR}/touch-control.sh"
}
