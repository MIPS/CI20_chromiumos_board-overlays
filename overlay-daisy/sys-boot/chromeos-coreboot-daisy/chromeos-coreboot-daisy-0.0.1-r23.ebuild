# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_COMMIT="696ece68cb6d522c248e800f168e675e4b4a7317"
CROS_WORKON_TREE="fc69b15696e2512dde1f1aea9daf4d990e69df30"
CROS_WORKON_PROJECT="chromiumos/third_party/coreboot"
CROS_WORKON_LOCALNAME="coreboot"

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
