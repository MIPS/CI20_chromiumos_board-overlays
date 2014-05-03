# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Chrome OS activate date mechanism"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

RDEPEND=""

S=${WORKDIR}

src_install() {
	dosbin "${FILESDIR}/activate_date"

	insinto "/etc/init"
	doins "${FILESDIR}/activate_date.conf"
}
