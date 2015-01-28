# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
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
# Panther itself requires no special firmware, but we modify panthers
# to add WiFi parts that require firmware when building test APs.
RDEPEND="
	chromeos-base/jabra-vold
	sys-kernel/linux-firmware
	media-libs/media-rules
"

DEPEND="${RDEPEND}"

src_install() {
	doappid "{C0E4276B-35C7-023D-BB4A-42D642B91E65}"
}
