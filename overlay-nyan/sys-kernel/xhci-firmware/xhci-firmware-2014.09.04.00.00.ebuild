# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Tegra XHCI firmware"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tbz2"

LICENSE="NVIDIA-r2"
SLOT="0"
KEYWORDS="arm"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /lib/firmware/tegra12x
	doins lib/firmware/tegra_xusb_firmware
}
