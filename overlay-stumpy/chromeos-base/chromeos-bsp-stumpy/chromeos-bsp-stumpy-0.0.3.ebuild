# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
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
	chromeos-base/oem-customization
	chromeos-base/jabra-vold
"
DEPEND=""

S=${WORKDIR}

src_install() {
	doappid "{2EE05B2F-3769-43B9-B78C-792F4A027971}"

	dosbin "${FILESDIR}/board_factory_wipe.sh"
	dosbin "${FILESDIR}/board_factory_reset.sh"

	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/avoid_suspend_when_headphone_jack_plugged"
	doins "${FILESDIR}/require_usb_input_device_to_suspend"
}
