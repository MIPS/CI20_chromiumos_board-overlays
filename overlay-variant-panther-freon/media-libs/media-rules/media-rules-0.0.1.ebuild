# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit udev

DESCRIPTION="Rules for setting up multimedia /dev/ nodes"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""

DEPEND="sys-fs/udev"
RDEPEND="${DEPEND}"

# Because this ebuild has no source package, "${S}" doesn't get
# automatically created.  The compile phase depends on "${S}" to
# exist, so we make sure "${S}" refers to a real directory.
#
# The problem is apparently an undocumented feature of EAPI 4;
# earlier versions of EAPI don't require this.
S="${WORKDIR}"

src_install() {
	udev_dorules "${FILESDIR}"/50-media.rules
	insinto /etc/init
	doins "${FILESDIR}"/udev-trigger-codec.conf
}
