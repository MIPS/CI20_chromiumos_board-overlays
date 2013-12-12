# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies or portage actions"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	chromeos-base/jabra-vold
"
DEPEND=""

S=${WORKDIR}

src_install() {
	doappid "{0A54D104-EC0D-450D-8588-FB106B2C6703}"

	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/avoid_suspend_when_headphone_jack_plugged"
	doins "${FILESDIR}/require_usb_input_device_to_suspend"
}
