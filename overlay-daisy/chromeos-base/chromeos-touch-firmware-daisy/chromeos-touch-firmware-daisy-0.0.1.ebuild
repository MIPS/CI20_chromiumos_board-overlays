# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit cros-binary

DESCRIPTION="Chromeos touchpad firmware payload."

LICENSE="BSD"
SLOT="0"
KEYWORDS="arm"

DEPEND=""

RDEPEND="${DEPEND}
	 chromeos-base/touch_updater"

PRODUCT_ID="CYTRA-116002-00"
FIRMWARE_VERSION="2.9"

CROS_BINARY_URI="${PF}.tbz2"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

cros-binary_add_overlay_uri daisy-private "${CROS_BINARY_URI}"

FW_NAME="${PRODUCT_ID}_${FIRMWARE_VERSION}.bin"
SYM_LINK_PATH="/lib/firmware/cyapa.bin"

S=${WORKDIR}

src_install() {
	cros-binary_src_install

	# Create symlink at /lib/firmware to the firmware binary.
	dosym "/opt/google/touch/firmware/${FW_NAME}" "${SYM_LINK_PATH}"
}
