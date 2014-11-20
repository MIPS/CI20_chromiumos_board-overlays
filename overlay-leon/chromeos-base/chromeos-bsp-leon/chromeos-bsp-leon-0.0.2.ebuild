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

# Add dependencies on other ebuilds from within this board overlay

# (MOCH) There is no buildable ec for leon on this branch. Added the dependency
# on chromeos-ec only to get a working ectool binary. The EC ends up getting
# built for board=bds
RDEPEND="
	!<chromeos-base/chromeos-bsp-leon-private-0.0.2
	chromeos-base/chromeos-ec
	media-gfx/ply-image
	chromeos-base/ec-utils
"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	doappid "{D3844706-6B0E-78DF-752C-00DCDF11E04B}"

	# Battery cut-off or power-off
	dosbin "${FILESDIR}/battery_cut_off.sh"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
	dosbin "${FILESDIR}/board_charge_battery.sh"
	dosbin "${FILESDIR}/board_poweroff.sh"

	insinto "/usr/share/factory/images"
	doins "${FILESDIR}/remove_ac.png"
	doins "${FILESDIR}/cutting_off.png"
	doins "${FILESDIR}/cutoff_failed.png"
	doins "${FILESDIR}/charging.png"
	doins "${FILESDIR}/connect_ac.png"
	doins "${FILESDIR}/powering_off.png"
	doins "${FILESDIR}/poweroff_failed.png"
	doins "${FILESDIR}/press_space_to_poweroff.png"

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/hdparm.conf"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*
}
