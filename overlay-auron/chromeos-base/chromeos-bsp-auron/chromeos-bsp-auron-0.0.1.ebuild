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
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

src_install() {
	doappid "{BAADD281-8816-1D16-5D83-0341376424DC}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
}
