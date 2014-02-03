# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Squawks private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-pcserial"

RDEPEND="
	chromeos-base/ec-utils
	pcserial? ( chromeos-base/serial-tty )
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	doappid "{777CE760-E315-FF86-2837-D51D10BA7C52}"
}
