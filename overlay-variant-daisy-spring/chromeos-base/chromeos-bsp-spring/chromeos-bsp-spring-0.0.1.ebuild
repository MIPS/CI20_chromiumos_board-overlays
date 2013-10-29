# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Spring bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"
IUSE=""

DEPEND=""
RDEPEND="
	!chromeos-base/chromeos-bsp-daisy-private
	!<chromeos-base/chromeos-bsp-spring-private-0.0.1-r18
	chromeos-base/ec-utils
"

S=${WORKDIR}

src_install() {
	# Install platform specific config file for power_manager
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/internal_backlight_no_als_ac_brightness"
	doins "${FILESDIR}/internal_backlight_no_als_battery_brightness"
	doins "${FILESDIR}/min_visible_backlight_level"
	doins "${FILESDIR}/power_supply_full_factor"
}
