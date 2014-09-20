# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_COMMIT="ac98f16d2460019942c70d537849b03fba784fa1"
CROS_WORKON_TREE="7e74506569342ace62b8f991b79977861a786b87"
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
