# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit udev

DESCRIPTION="Rules for setting up multimedia /dev/ nodes"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

DEPEND=""
RDEPEND="sys-fs/udev"

S="${WORKDIR}"

src_install() {
	udev_dorules "${FILESDIR}"/50-media.rules
	insinto /etc/init
	doins "${FILESDIR}"/udev-trigger-codec.conf
}
