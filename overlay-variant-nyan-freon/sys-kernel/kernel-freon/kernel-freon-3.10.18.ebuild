# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_COMMIT="2dfc215cb34d42bbe665597990f699cb086932a3"
CROS_WORKON_TREE="2dfc215cb34d42bbe665597990f699cb086932a3^{tree}"
CROS_WORKON_PROJECT="chromiumos/third_party/kernel/3.10"
CROS_WORKON_LOCALNAME="kernel/3.10"
CROS_WORKON_BLACKLIST="1"

inherit cros-workon cros-kernel2 eutils

DESCRIPTION="Chrome OS Kernel-nyan_freon"

KEYWORDS="*"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_prepare() {
	cros-workon_src_prepare
	epatch ${FILESDIR}/*.patch
}

src_configure() {
	cros-kernel2_src_configure
}
