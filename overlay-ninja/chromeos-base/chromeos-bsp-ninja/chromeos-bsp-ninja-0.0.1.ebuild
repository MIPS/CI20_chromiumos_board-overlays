# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ninja bsp (meta package to pull in driver/tool deps)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

RDEPEND="
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
	media-gfx/ply-image
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_install() {
	doappid "{555B868F-306A-3E26-6687-FC081968D43A}"
	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"
}
