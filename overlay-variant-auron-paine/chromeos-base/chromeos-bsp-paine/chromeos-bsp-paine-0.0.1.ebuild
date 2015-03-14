# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	!<chromeos-base/chromeos-bsp-auron-0.0.1-r3
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{0AA3F9E1-A088-9252-50B8-5A1345D09AEB}"

	# Install Bluetooth ID override.
	insinto "/etc/bluetooth"
	doins "${FILEDIR}/main.conf"
}
