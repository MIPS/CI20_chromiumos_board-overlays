# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Stout public bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	!<chromeos-base/chromeos-bsp-stout-private-0.0.1-r13
	chromeos-base/trackpoint-xorg-conf
"

S=${WORKDIR}

src_install() {
	doappid "{6988C65F-7119-4DF2-8064-2E286F4748D4}"

	insinto "/etc/init"
	doins "${FILESDIR}/rf-led-handler.conf"
}
