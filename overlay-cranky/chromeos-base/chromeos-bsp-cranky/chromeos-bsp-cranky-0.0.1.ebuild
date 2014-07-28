# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Cranky private bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

RDEPEND="
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{DEA86483-0D13-D8A2-125F-795B7C6712C3}"
}
