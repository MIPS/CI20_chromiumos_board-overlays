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

# Add dependencies on other ebuilds from within this board overlay

# (MOCH) There is no buildable ec for leon on this branch. Added the dependency
# on chromeos-ec only to get a working ectool binary. The EC ends up getting
# built for board=bds
RDEPEND="
	!<chromeos-base/chromeos-bsp-leon-private-0.0.1-r9
	chromeos-base/chromeos-ec
	media-gfx/ply-image
	chromeos-base/ec-utils
"

DEPEND="${RDEPEND}"

src_install() {
	doappid "{D3844706-6B0E-78DF-752C-00DCDF11E04B}"

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/hdparm.conf"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/wakeup_input_device_names"
	doins "${FILESDIR}/low_battery_shutdown_percent"
	doins "${FILESDIR}/low_battery_shutdown_time_s"

	exeinto "/opt/google/touch"
	doexe "${FILESDIR}/touch-control.sh"
}
