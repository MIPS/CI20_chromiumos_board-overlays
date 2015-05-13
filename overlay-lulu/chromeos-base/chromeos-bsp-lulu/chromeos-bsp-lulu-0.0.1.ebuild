# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid udev

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	chromeos-base/chromeos-bsp-baseboard-auron
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
	media-gfx/ply-image
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{40C6BCAB-B8D4-466F-9C3C-069B8CAC36D7}"

	# Install platform specific config files for power_manager.
	udev_dorules "${FILESDIR}/92-powerd-overrides.rules"
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Wiping scripts.
	dosbin "${FILESDIR}"/sbin/*.sh
	insinto "/usr/share/factory/images"
	doins "${FILESDIR}"/images/*.png
}
