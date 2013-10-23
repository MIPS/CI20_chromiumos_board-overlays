# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Board specific light sensor configuration files"
HOMEPAGE="http://src.chromium.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	chromeos-base/vpd
"

S="${WORKDIR}"

src_install() {
	# Install light sensor tuning script.
	exeinto "/lib/udev"
	doexe "${FILESDIR}/light-sensor-set-multiplier.sh"

	# Install light sensor udev rules.
	insinto "/lib/udev/rules.d"
	doins "${FILESDIR}/99-light-sensor.rules"
}
