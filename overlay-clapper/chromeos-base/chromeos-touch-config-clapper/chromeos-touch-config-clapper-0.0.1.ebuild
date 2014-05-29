# Copyright (c) 2014 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Install configuration data for Atmel chips"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RDEPEND="${DEPEND}
	 chromeos-base/touch_updater"

TOUCH_CONFIG_PATH="/opt/google/touch/config"
TS_CONFIG_MAPPING_FILE="ts_config_mapping"
TS_CONFIG_FILE_OFILM="1664t-ofilm.raw"
TS_CONFIG_LINK_OFILM="/lib/firmware/maxtouch-ts-ofilm.cfg"
TS_CONFIG_FILE_MUTTO="1664t-mutto.raw"
TS_CONFIG_LINK_MUTTO="/lib/firmware/maxtouch-ts-mutto.cfg"

S=${WORKDIR}

src_install() {
	insinto "${TOUCH_CONFIG_PATH}"
        doins "${FILESDIR}/${TS_CONFIG_MAPPING_FILE}"
	doins "${FILESDIR}/${TS_CONFIG_FILE_OFILM}"
	doins "${FILESDIR}/${TS_CONFIG_FILE_MUTTO}"
	dosym "${TOUCH_CONFIG_PATH}/${TS_CONFIG_FILE_OFILM}" "${TS_CONFIG_LINK_OFILM}"
	dosym "${TOUCH_CONFIG_PATH}/${TS_CONFIG_FILE_MUTTO}" "${TS_CONFIG_LINK_MUTTO}"
}
