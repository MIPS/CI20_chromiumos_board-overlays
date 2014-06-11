# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/mtk00874/kernel-mediatek.git"
EGIT_COMMIT="b5a99ddf6a43a9f771093a42f8da009a2680bab2"
CROS_WORKON_BLACKLIST="1"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon cros-kernel2

DESCRIPTION="Kernel 3.14 For MT8127"
KEYWORDS="-* arm"

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
	CHROMEOS_KERNEL_CONFIG="${S}/arch/arm/configs/mt8127_defconfig"
	cros-kernel2_src_configure
}
