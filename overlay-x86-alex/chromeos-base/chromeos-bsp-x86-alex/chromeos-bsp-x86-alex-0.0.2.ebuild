# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit toolchain-funcs udev

DESCRIPTION="Board-specific packages for x86-alex"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="!chromeos-base/light-sensor"

S="${WORKDIR}"

src_install() {
	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install board-specific info
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/intel-hda-powersave.conf"
}
