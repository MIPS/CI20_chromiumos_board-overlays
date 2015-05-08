# Copyright (c) 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/MIPS"
CROS_WORKON_PROJECT="CI20_linux"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="a2854f8fc6db57b37f7a9ec29de0f66bcc192ad8"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel for CI20"
KEYWORDS="-* mips"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
	cros-kernel2_src_install
}
