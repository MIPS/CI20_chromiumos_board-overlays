# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies or portage actions"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# These packages are meant to set up the Chromium OS Basic environment to
# properly handle the services required by the lab infrastructure.
RDEPEND="
	chromeos-base/chromeos-init
	chromeos-base/chromeos-test-testauthkeys
	chromeos-base/openssh-server-init
	chromeos-base/jabra-vold
	net-misc/dhcp
"

# Chromium OS Autotest Server and Devserver Deps.
RDEPEND="${RDEPEND}
	chromeos-base/autotest-server
	chromeos-base/devserver
"

DEPEND=""

S=${WORKDIR}

src_install() {
	doappid "{0A54D104-EC0D-450D-8588-FB106B2C6703}"

	insinto /etc/init
	doins "${FILESDIR}/moblab-network-init.conf"
	doins "${FILESDIR}/moblab-dhcpd-init.conf"
	doins "${FILESDIR}/moblab-database-init.conf"

	insinto /etc/dhcp
	doins "${FILESDIR}/dhcpd-moblab.conf"

	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}/avoid_suspend_when_headphone_jack_plugged"
	doins "${FILESDIR}/require_usb_input_device_to_suspend"

	dosym /home/chronos/user/.boto /root/.boto

	# TODO (crbug.com/348172) - This is a temporary fix to not wipe
	# stateful when booting off USB as a base image.
	dodir "/mnt/stateful_partition"
	touch "${D}/mnt/stateful_partition/.developer_mode"
}
