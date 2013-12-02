# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_INCREMENTAL_BUILD="0"

inherit cros-workon cros-kernel2 eutils

# The tarball for this package was created from this repo:
#     https://github.com/beagleboard/kernel.git
# That repo is a collection of patches, plus a script to apply them
# to a linux kernel.
#
# The specific set of patches came from commit 8a908ca, on a branch
# named "3.8"; that commit was tip of tree on July 17, when this
# snapshot was taken.  The patches were applied against Linux kernel
# version 3.8.13.
#
# The config file for the kernel was based on the config provided
# with the beagleboard repo, with selected changes made to meet
# Chrome OS config preferences.
#
# This package is in a private overlay for now for the sake of
# keeping "am335x-pm-firmware.bin" private.
#
# TODO(jrbarnette):  Really, we want to eliminate this ebuild
# altogether, and rely on the standard Chromium OS kernel ebuild.
# http://crbug.com/302022

DESCRIPTION="Chrome OS Kernel-beaglebone"
HOMEPAGE="http://src.chromium.org"
LOCAL_MIRROR="commondatastorage.googleapis.com/chromeos-localmirror/distfiles"
SRC_URI="https://${LOCAL_MIRROR}/${P}.tar.bz2"

LICENSE="LICENCE.TI-pm_firmware"
SLOT="0"
KEYWORDS="arm"

DEPEND="!sys-kernel/chromeos-kernel-next
		!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_prepare() {
	cros-workon_src_prepare
	epatch "${FILESDIR}"/*.patch
}

src_unpack() {
	default
}

src_configure() {
	CHROMEOS_KERNEL_CONFIG="${FILESDIR}/config"
	cp "${FILESDIR}"/am335x-pm-firmware.bin firmware || die
	cros-kernel2_src_configure
}
