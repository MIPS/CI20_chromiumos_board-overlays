# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_COMMIT="14b589fe805e2ea1ac9277f96016d771d1fe7b03"
CROS_WORKON_TREE="096f2902a674513699ad676a895b9dcb614f5e0f"
CROS_WORKON_PROJECT="chromiumos/third_party/kernel-next"
CROS_WORKON_LOCALNAME="kernel-next"
CROS_WORKON_BLACKLIST="1"

inherit cros-workon cros-kernel2 eutils

DESCRIPTION="Chrome OS Kernel-link_freon"

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
