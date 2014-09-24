# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Board specific compressed swap (zram) size"
HOMEPAGE="http://src.chromium.org"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

S="${WORKDIR}"

src_install() {
	insinto "/etc/default"
	doins "${FILESDIR}/zram-size"
}
