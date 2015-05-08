# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/MIPS"
CROS_WORKON_PROJECT="CI20_u-boot"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="6a9d3738225351efe9a2134a1ce512e7f82728a7"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit flag-o-matic git-2 cros-workon

DESCRIPTION="u-boot For CI20"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* mips"

################

src_compile() {
	export LDFLAGS=$(raw-ldflags)
	export ARCH=mips
	export CROSS_COMPILE=${CHOST}-

	# Build for both nand and mmc
	emake O=build-nand ci20
	emake O=build-mmc ci20_mmc
}

src_install() {
	insinto /boot
	exeinto /boot

	# Install main images
	newins build-nand/u-boot.img u-boot-nand.img
	newins build-nand/spl/u-boot-spl.bin u-boot-spl-nand.bin
	newins build-mmc/u-boot.img u-boot-mmc.img
	newins build-mmc/spl/u-boot-spl.bin u-boot-spl-mmc.bin

	# Install mkenvimage as needed by final image generator
	doexe build-nand/tools/mkenvimage
}
