# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid

DESCRIPTION="Butterfly public bsp (meta package to pull in driver/tool dependencies)"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	!<chromeos-base/chromeos-bsp-butterfly-private-0.0.2
"

S=${WORKDIR}

src_install() {
	doappid "{6372E332-9A26-4CE3-9C39-93D8A4E383AF}"

	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/wakeup_input_device_names"
	doins "${FILESDIR}/min_visible_backlight_level"

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/runtime-pm.conf"
	doins "${FILESDIR}/intel-hda-powersave.conf"
}
