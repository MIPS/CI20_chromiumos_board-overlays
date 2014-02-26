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
TS_CONFIG_FILE="1664t.raw"
TS_CONFIG_LINK="/lib/firmware/maxtouch-ts.cfg"

S=${WORKDIR}

src_install() {
	insinto "${TOUCH_CONFIG_PATH}"
	doins "${FILESDIR}/${TS_CONFIG_FILE}"
	dosym "${TOUCH_CONFIG_PATH}/${TS_CONFIG_FILE}" "${TS_CONFIG_LINK}"
}
