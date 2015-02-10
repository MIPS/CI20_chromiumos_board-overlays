# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="preloader and lk for oak"
HOMEPAGE="https://github.com/mtk09422/chromiumos-third_party-mediatek-firmware/"
SRC_URI="https://github.com/mtk09422/chromiumos-third_party-mediatek-firmware/archive/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* arm"

S=${WORKDIR}/chromiumos-third_party-mediatek-firmware-${P}

src_install() {
	insinto /firmware/prebuilt
	doins firmware/*
}
