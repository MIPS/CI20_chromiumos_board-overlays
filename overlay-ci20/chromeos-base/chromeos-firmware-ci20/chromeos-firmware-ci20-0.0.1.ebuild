# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Firmware for CI20 overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

S=${WORKDIR}

src_install() {
	# Wifi Firmware (this blob is NOT the same as the one in linux-firmware)
	insinto "/lib/firmware/brcm"
	doins "${FILESDIR}/brcmfmac4330-sdio.bin"
	doins "${FILESDIR}/brcmfmac4330-sdio.txt"
}
