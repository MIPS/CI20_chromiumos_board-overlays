# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid udev

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND="!chromeos-base/light-sensor"
RDEPEND="${DEPEND}
	chromeos-base/chromeos-board-info-link
	chromeos-base/chromeos-touch-config-link
	chromeos-base/ca0132-dsp-firmware
	chromeos-base/ec-utils
	chromeos-base/lte-quirks
	chromeos-base/temp-metrics
"

S=${WORKDIR}

src_install() {
	doappid "{F26D159B-52A3-491A-AE25-B23670A66B32}"

	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Install board-specific info.
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/cpufreq.conf"
}
