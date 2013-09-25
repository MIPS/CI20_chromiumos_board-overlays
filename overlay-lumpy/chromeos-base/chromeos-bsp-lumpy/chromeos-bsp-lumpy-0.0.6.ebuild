# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit toolchain-funcs appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="${RDEPEND}
	sys-apps/iotools
	chromeos-base/light-sensor
"
DEPEND=""

# Y3300 support.
RDEPEND="${RDEPEND}
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

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager"
	doins "${FILESDIR}/wakeup_input_device_names"
}
