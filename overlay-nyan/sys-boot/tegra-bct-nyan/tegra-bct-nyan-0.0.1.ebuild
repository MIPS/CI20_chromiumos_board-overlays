# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit tegra-bct

DESCRIPTION="Nyan BCT file"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* arm"
IUSE="bootflash-spi bootflash-emmc"
REQUIRED_USE="
	bootflash-spi? ( !bootflash-emmc )
	bootflash-emmc? ( !bootflash-spi )
"

S=${WORKDIR}

src_configure() {
	local board="nyan"

	if use bootflash-emmc; then
		TEGRA_BCT_FLASH_CONFIG="${board}/emmc.cfg"
	elif use bootflash-spi; then
		TEGRA_BCT_FLASH_CONFIG="${board}/spi.cfg"
	fi

	TEGRA_BCT_SDRAM_CONFIG="${board}/sdram.cfg"

	TEGRA_BCT_ODM_DATA_CONFIG="${board}/odmdata.cfg"

	TEGRA_BCT_CHIP_FAMILY="t124"

	tegra-bct_src_configure
}
