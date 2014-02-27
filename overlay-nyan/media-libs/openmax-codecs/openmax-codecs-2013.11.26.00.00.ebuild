# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="OpenMAX binary libraries"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tbz2"

LICENSE="NVIDIA-codecs"
SLOT="0"
KEYWORDS="arm"
IUSE=""

RDEPEND="~sys-apps/nvrm-${PV}
	virtual/opengles
	"

S=${WORKDIR}

src_install() {
	insinto /lib/firmware/tegra12x
	doins lib/firmware/tegra12x/nvhost_msenc031.fw
	doins lib/firmware/tegra12x/nvhost_tsec.fw
	doins lib/firmware/tegra12x/vic03_ucode.bin
}
