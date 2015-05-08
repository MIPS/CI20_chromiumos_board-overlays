# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="CI20 bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""

RDEPEND="sys-boot/ci20-u-boot"

S=${WORKDIR}

src_install() {
	insinto "/lib/firmware/brcm"
	doins "${FILESDIR}/brcmfmac4330-sdio.txt"
}
