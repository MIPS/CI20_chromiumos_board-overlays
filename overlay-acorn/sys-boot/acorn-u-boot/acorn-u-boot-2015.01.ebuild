# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit flag-o-matic

DESCRIPTION="u-boot T3.0 For Acorn"
SRC_URI="https://github.com/Kinoma/acorn_uboot/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* arm"
RESTRICT="mirror"
S=${WORKDIR}/acorn_uboot-${PV}

src_compile() {
	export LDFLAGS=$(raw-ldflags)
	export CROSS_COMPILE=${CHOST}-
	export CROSS_COMPILE_BH=${CHOST}-
	./build.pl -f spi -v 2013.01-2014_T3_HCC -b armada_38x_customer0 -i spi:nor -c -o output
}

src_install() {
	insinto /boot
	exeinto /boot
	doins output/u-boot.bin
	doins output/u-boot-uart.bin
	doins output/u-boot-uart-plus.bin
	doexe output/sx-at91
	doexe tools/marvell/xmodem/xmodem_boot.pattern
}
