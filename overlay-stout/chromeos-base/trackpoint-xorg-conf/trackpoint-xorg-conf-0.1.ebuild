# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Trackpoint xorg configuration file for Stout"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}

src_install() {
	insinto /etc/X11/xorg.conf.d
	doins "${FILESDIR}/20-trackpoint.conf"
}
