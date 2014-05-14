# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_COMMIT="4fd50104d0b8e64b78fa543efd53564887209cde"
CROS_WORKON_TREE="1e0383a06609251b6253556d0ddd01214b0867db"
CROS_WORKON_PROJECT="chromiumos/third_party/kernel/3.8"
CROS_WORKON_LOCALNAME="kernel/3.8"
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
