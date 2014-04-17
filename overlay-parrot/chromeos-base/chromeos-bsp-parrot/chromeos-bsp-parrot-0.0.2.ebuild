# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	sys-apps/bootcache
	sys-apps/iotools
"
DEPEND=""

S=${WORKDIR}

src_install() {
	doappid "{9D137383-EB72-4BA9-A523-91AC0853F8AD}"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/wakeup_input_device_names"
	doins "${FILESDIR}/dark_resume_suspend_durations"
	doins "${FILESDIR}/dark_resume_devices"
	doins "${FILESDIR}/dark_resume_sources"
	doins "${FILESDIR}/dark_resume_battery_margins"
	doins "${FILESDIR}/allow_docked_mode"

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/intel-hda-powersave.conf"
	doins "${FILESDIR}/runtime-pm.conf"

	exeinto "/opt/google/touch"
	doexe "${FILESDIR}/touch-control.sh"
}
