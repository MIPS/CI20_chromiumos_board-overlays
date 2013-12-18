# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT="c5ef875f6d148964b8ad62a3fe79916c758dbc57"
CROS_WORKON_TREE="9483a7ac07123057bf1c9ae2ebae13f5490c393b"
CROS_WORKON_PROJECT="chromiumos/third_party/coreboot"
CROS_WORKON_LOCALNAME="coreboot"

COREBOOT_BOARD="snow"
COREBOOT_BOARD_ROOT="google/snow"
COREBOOT_BUILD_ROOT="builds/snow"

inherit cros-board cros-workon cros-coreboot

KEYWORDS="arm"

DEPEND="sys-boot/exynos-pre-boot"

RDEPEND="!sys-boot/chromeos-coreboot"

src_prepare() {
	# src is installed by "exynos-pre-boot".
	local src="${SYSROOT}/firmware/u-boot.bl1.bin"
	# dest is required by Makefile.inc in coreboot source tree.
	local dest="3rdparty/cpu/samsung/exynos5250/bl1.bin"

	mkdir -p "$(dirname "${dest}")"
	cp -pf "${src}" "${dest}" || die
}
