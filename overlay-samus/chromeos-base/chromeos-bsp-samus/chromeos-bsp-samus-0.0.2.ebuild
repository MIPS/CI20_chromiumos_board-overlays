# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit appid

DESCRIPTION="Ebuild which pulls in any necessary ebuilds as dependencies
or portage actions."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

# Add dependencies on other ebuilds from within this board overlay
RDEPEND="
	chromeos-base/chromeos-accelerometer-init
	chromeos-base/chromeos-touch-config-samus
	chromeos-base/ec-utils
	sys-kernel/linux-firmware
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	doappid "{F67500C1-C6D8-5287-E4EC-F9BBB4AEE5C5}"

	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*
	insinto "/etc/init"
	doins "${FILESDIR}"/ec-report-panic-data.conf

	# Install rt5677 codec DSP firmware.
	insinto "/lib/firmware"
	doins "${FILESDIR}"/rt5677_elf_vad

	# Install Bluetooth ID Override
	insinto "/etc/bluetooth"
	doins "${FILESDIR}"/main.conf
}
