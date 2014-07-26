# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
EGIT_BRANCH="msm-wip-iommu"
EGIT_REPO_URI="git://people.freedesktop.org/~robclark/linux"
EGIT_COMMIT="1ff7fedca7472096dbca613db402241b3d05cf6f"
CROS_WORKON_BLACKLIST="1"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit cros-workon cros-kernel2

DESCRIPTION="Kernel 3.16 For IFC6410"
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
	CHROMEOS_KERNEL_CONFIG="${S}/arch/arm/configs/msm_defconfig"
	cros-kernel2_src_configure
}
