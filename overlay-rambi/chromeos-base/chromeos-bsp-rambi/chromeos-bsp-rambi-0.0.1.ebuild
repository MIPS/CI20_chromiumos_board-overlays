# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Rambi private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-pcserial"
S="${WORKDIR}"

RDEPEND="
	!<chromeos-base/chromeos-bsp-rambi-private-0.0.1-r2
	chromeos-base/chromeos-touch-config-rambi
	pcserial? ( chromeos-base/serial-tty )
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{22235CFE-C5A2-414E-688D-239AC44675DB}"
}
