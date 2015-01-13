# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Gizmo bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-shells/bash
"

# Because this ebuild has no source package, "${S}" doesn't get
# automatically created.  The compile phase depends on "${S}" to
# exist, so we make sure "${S}" refers to a real directory.
#
# The problem is apparently an undocumented feature of EAPI 4;
# earlier versions of EAPI don't require this.
S="${WORKDIR}"

src_install() {
	insinto /etc/privetd
	doins "${FILESDIR}/privetd/config"
}
