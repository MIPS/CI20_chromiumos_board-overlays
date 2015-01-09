# Copyright 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit udev

DESCRIPTION="Veyron bsp (meta package to pull in driver/tool dependencies)"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* arm"
IUSE=""

# Add dependencies on other ebuilds from within this board overlay
DEPEND=""
RDEPEND="${DEPEND}
	chromeos-base/AP6335-wifi-bin
	x11-drivers/mali-rules
	media-libs/media-rules
	net-wireless/broadcom
"

S=${WORKDIR}

src_install() {
	# Install platform specific config files for power_manager.
	insinto "/usr/share/power_manager/board_specific"
	doins "${FILESDIR}"/powerd_prefs/*

	# Install platform specific files for bcm4354 bluetooth.
	insinto "/etc/init"
	doins "${FILESDIR}"/brcm_patchram_plus.conf
	insinto "/etc/modprobe.d"
	doins "${FILESDIR}"/blacklist-btsdio.conf

	# Install platform specific files for usb camera.
	udev_dorules "${FILESDIR}/99-usb-camera-quirks.rules"
	exeinto "$(udev_get_udevdir)"
	doexe "${FILESDIR}/usb-camera-quirks.sh"
}
