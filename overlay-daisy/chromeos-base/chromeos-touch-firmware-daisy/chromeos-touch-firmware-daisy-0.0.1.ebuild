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

CYPRESS_PRODUCT_ID="CYTRA-116002-00"
CYPRESS_FIRMWARE_VERSION="2.13"

ATMEL_PRODUCT_ID="130.35"
ATMEL_FIRMWARE_VERSION="2.0.170"


CROS_BINARY_URI="${PF}.tbz2"
CROS_BINARY_INSTALL_FLAGS="--strip-components=1"

cros-binary_add_overlay_uri daisy-private "${CROS_BINARY_URI}"

CYPRESS_FW_NAME="${CYPRESS_PRODUCT_ID}_${CYPRESS_FIRMWARE_VERSION}.bin"
CYPRESS_SYM_LINK_PATH="/lib/firmware/cyapa.bin"

ATMEL_FW_NAME="${ATMEL_PRODUCT_ID}_${ATMEL_FIRMWARE_VERSION}.bin"
ATMEL_SYM_LINK_PATH="/lib/firmware/maxtouch-tp.fw"

S=${WORKDIR}

src_install() {
	cros-binary_src_install

	# Create symlinks at /lib/firmware to the firmware binaries.
	dosym "/opt/google/touch/firmware/${CYPRESS_FW_NAME}" "${CYPRESS_SYM_LINK_PATH}"
	dosym "/opt/google/touch/firmware/${ATMEL_FW_NAME}" "${ATMEL_SYM_LINK_PATH}"
}
