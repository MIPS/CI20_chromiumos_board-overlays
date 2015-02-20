# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
EGIT_BRANCH="linux-3.10.39-14t3_acorn"
EGIT_REPO_URI="https://github.com/Kinoma/acorn_kernel.git"
EGIT_COMMIT="1de3c494e2c1c46aa504133257b349b71e3e44fe"
CROS_WORKON_PROJECT="chromiumos/third_party/kernel"
CROS_WORKON_BLACKLIST="1"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon cros-kernel2 git-2

DESCRIPTION="Kernel 3.10 For Acorn"
KEYWORDS="~*"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel"
RDEPEND="${DEPEND}"

src_unpack() {
	# Call git-2_src_unpack directly because cros-workon_src_unpack
	# would override EGIT_REPO_URI as CROS_GIT_HOST_URL, that is
	# https://chromium.googlesource.com
	git-2_src_unpack
}

src_configure() {
	cros-kernel2_src_configure
}
