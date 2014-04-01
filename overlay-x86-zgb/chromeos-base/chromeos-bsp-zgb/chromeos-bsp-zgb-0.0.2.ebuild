# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid udev

DESCRIPTION="Board-specific packages for ZGB"
HOMEPAGE="http://src.chromium.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="!chromeos-base/light-sensor"
# modemmanager provides Ericsson support.
RDEPEND="${DEPEND}
	app-laptop/laptop-mode-tools
	chromeos-base/chrontel
	chromeos-base/vpd
	sys-apps/iotools
	virtual/modemmanager
"

S=${WORKDIR}

src_install() {
	doappid "{23F5C60F-7655-4BF4-90FB-BFDE16408308}"

	# Install platform-specific ambient light sensor configuration.
	udev_dorules "${FILESDIR}/99-light-sensor.rules"
	exeinto $(udev_get_udevdir)
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install board-specific info
	insinto "/etc/laptop-mode/conf.d/board-specific"
	doins "${FILESDIR}/intel-hda-powersave.conf"
}
