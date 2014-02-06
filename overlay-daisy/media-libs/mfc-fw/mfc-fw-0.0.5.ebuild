# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Multi-Format Codec Firmware Binary for Exynos5250"
SLOT="0"
LICENSE="Google-TOS"
KEYWORDS="-* arm"
IUSE=""

SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tbz2"

S="${WORKDIR}"

# The tbz2 file contains the following:
# mfc-fw/lib/firmware/s5p-mfc-v6.fw
src_install() {
	insinto /lib/firmware
	newins mfc-fw/lib/firmware/s5p-mfc-v6.fw s5p-mfc-v6.fw
	fowners root:root /lib/firmware/s5p-mfc-v6.fw
}
